from enum import auto
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

database_url = os.environ.get('url')
password = os.environ.get('password')
cert_path = os.environ.get('cert_path')
SQLALCHEMY_DATABASE_URL = f"mysql+pymysql://pavangole:{password}@{database_url}/frs"
engine = create_engine(SQLALCHEMY_DATABASE_URL,connect_args={
    "ssl_ca": f"{cert_path}/DigiCertGlobalRootCA.crt.pem"
})
SessionLocal = sessionmaker(autocommit=False,autoflush=False,bind=engine)
Base = declarative_base()