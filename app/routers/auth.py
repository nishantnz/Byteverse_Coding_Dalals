import email
from turtle import up
from fastapi import APIRouter, Depends
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session
from starlette.responses import Response
from starlette.responses import JSONResponse
from typing import Annotated, Optional
import base64
from passlib.context import CryptContext
from datetime import datetime, timedelta
import jwt
from jwt import PyJWTError
from pydantic import BaseModel
from fastapi import Depends, FastAPI, HTTPException
from fastapi.encoders import jsonable_encoder
from fastapi.security import OAuth2PasswordRequestForm, OAuth2
from fastapi.security.base import SecurityBase
from fastapi.security.utils import get_authorization_scheme_param
from fastapi.openapi.models import OAuthFlows as OAuthFlowsModel
from starlette.status import HTTP_403_FORBIDDEN
from starlette.responses import RedirectResponse, Response, JSONResponse
from starlette.requests import Request
from databases import schemas
from databases import crud
from databases.getdb import get_db

router = APIRouter(prefix="/auth")

# to get a string like this run:
# openssl rand -hex 32
SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str = None


class OAuth2PasswordBearerCookie(OAuth2):
    def __init__(
            self,
            tokenUrl: str,
            scheme_name: str = None,
            scopes: dict = None,
            auto_error: bool = True,
    ):
        if not scopes:
            scopes = {}
        flows = OAuthFlowsModel(password={"tokenUrl": tokenUrl, "scopes": scopes})
        super().__init__(flows=flows, scheme_name=scheme_name, auto_error=auto_error)

    async def __call__(self, request: Request) -> Optional[str]:
        header_authorization: str = request.headers.get("Authorization")
        cookie_authorization: str = request.cookies.get("Authorization")

        header_scheme, header_param = get_authorization_scheme_param(
            header_authorization
        )
        cookie_scheme, cookie_param = get_authorization_scheme_param(
            cookie_authorization
        )

        if header_scheme.lower() == "bearer":
            authorization = True
            scheme = header_scheme
            param = header_param

        elif cookie_scheme.lower() == "bearer":
            authorization = True
            scheme = cookie_scheme
            param = cookie_param

        else:
            authorization = False

        if not authorization or scheme.lower() != "bearer":
            if self.auto_error:
                raise HTTPException(
                    status_code=HTTP_403_FORBIDDEN, detail="Not authenticated"
                )
            else:
                return None
        return param


class BasicAuth(SecurityBase):
    def __init__(self, scheme_name: str = None, auto_error: bool = True):
        self.scheme_name = scheme_name or self.__class__.__name__
        self.auto_error = auto_error

    async def __call__(self, request: Request) -> Optional[str]:
        authorization: str = request.headers.get("Authorization")
        scheme, param = get_authorization_scheme_param(authorization)
        if not authorization or scheme.lower() != "basic":
            if self.auto_error:
                raise HTTPException(
                    status_code=HTTP_403_FORBIDDEN, detail="Not authenticated"
                )
            else:
                return None
        return param


basic_auth = BasicAuth(auto_error=False)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearerCookie(tokenUrl="/token")
app = FastAPI(docs_url=None, redoc_url=None, openapi_url=None)


def authenticate_user(email: str, password: str, db: Session):
    user = crud.get_user_by_email(email=email, db=db)
    if user is None:
        return False
    if user.hashed_password != password:
        return False
    return user, user.age


def create_access_token(*, data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=HTTP_403_FORBIDDEN, detail="Could not validate credentials"
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        print(username)
        if username is None:
            raise credentials_exception
        token_data = TokenData(username=username)
    except PyJWTError:
        raise credentials_exception
    user = crud.get_user_by_id(user_id=token_data.username, db=db)
    if user is None:
        raise credentials_exception
    return user


async def get_current_active_user(current_user=Depends(get_current_user)):
    return current_user


@router.get("/")
async def homepage():
    return "Welcome to the security test!"


@router.post("/token", response_model=Token)
async def route_login_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user, age = authenticate_user(email=form_data.username, password=form_data.password, db=db)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@router.get("/logout")
async def route_logout_and_remove_cookie():
    response = RedirectResponse(url="/auth/login")
    response.delete_cookie("Authorization", domain="myproject.local")
    return response


@router.post('/login')
async def login_basic(auth: BasicAuth = Depends(basic_auth), db: Session = Depends(get_db)):
    print(auth)
    if not auth:
        return JSONResponse({'status': 'failed'})
    try:
        decoded = base64.b64decode(auth).decode("ascii")
        username, _, password = decoded.partition(":")
        user, age = authenticate_user(email=username, password=password, db=db)
        if not user:
            raise HTTPException(status_code=400, detail="Incorrect email or password")
        access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = create_access_token(
            data={"sub": user.user_id}, expires_delta=access_token_expires
        )

        token = jsonable_encoder(access_token)
        redirect = "False"
        print(age)
        if age is None:
            redirect = "True"
        response = JSONResponse({'status': "success", 'redirect': redirect, 'token': token},
                                headers={'token': "{token}"})
        response.set_cookie(
            key="Authorization",
            value=f"Bearer {token}",
            domain="myproject.local",
            httponly=False,
            max_age=1800,
            expires=1800,
        )
        return response

    except Exception as e:
        return JSONResponse({'status': 'failed'})


@router.post('/register')
def register(user: schemas.UserCreate, db: Session = Depends(get_db)):
    result = crud.create_user(db=db, user=user)
    if result:
        return {
            "api": "v1",
            "status": "success"
        }
    else:
        return {
            "api": "v1",
            "status": "failed"
        }

@router.post("/forgot_password")
def forgot_password(user: schemas.UserCreate,db: Session=Depends(get_db)):
    try:
        result = crud.get_user_by_email(email = user.email ,db=db )
        if result:
            dic = {'email': user.email, 'hashed_password': user.password}
            crud.update_password(db=db,update_items=dic,email=user.email)
            return {
                'status': 'success',
                'description': 'password changed succesfully'
            }
        return {
            'status': 'failed',
            'description': 'user doesnt exist'
        }
    except Exception as e:
        print(e)
        return {
            "Internal Server Error"
        }
