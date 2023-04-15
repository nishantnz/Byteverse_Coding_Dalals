from lib2to3.pgen2.token import GREATER
from operator import or_
from pyexpat import model
from sqlalchemy.orm import Session
from sqlalchemy import or_
from databases import models, schemas
import time
from typing import List


# get system current time and convert it to unix epoch timestamp
def get_current_time():
    return int(time.time())


# generate random user_id that is always unique
def generate_user_id():
    import random
    import string
    user_id = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10))
    return user_id


def create_user(db: Session, user: schemas.UserCreate):
    # check user already exists otherwise create user
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    print(db_user)
    if db_user:
        return False
    db_user = models.User(email=user.email, hashed_password=user.password,user_id=generate_user_id())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return True


def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()


def get_user_by_id(db: Session, user_id: str):
    return db.query(models.User).filter(models.User.user_id == user_id).first()


def create_user_info(db: Session, user: schemas.User):
    result = get_user_by_email(db, user.email)
    if result.age is not None:
        return False
    db_user = models.User(club_member_status=user.club_member_status,
                          fashion_news_frequency=user.fashion_news_frequency, age=user.age,
                          postal_code=user.postal_code, name=user.name)
    hello = db_user.__dict__.copy()
    hello.pop('_sa_instance_state')
    db.query(models.User).filter(models.User.email == user.email).update(hello)
    db.commit()
    return True


def update_user_info(db: Session, update_items: dict, user_id: str):
    print("I am in Crud")
    db.query(models.User).filter(models.User.user_id == user_id).update(update_items)
    db.commit()


def get_transactions_by_id(db: Session, id: str):
    # return all transactions and items descrption and price for a user id
    return db.query(models.Transactions, models.Item).filter(models.Transactions.user_id == id).join(models.Item).all()


def creat_item(db: Session, item: schemas.ItemBase):
    # check item already exists otherwise create item
    db_item = db.query(models.Item).filter(models.Item.item_id == item.item_id).first()
    if db_item:
        return False
    db_item = models.Item(item_id=item.item_id, product_name=item.product_name,
                          product_type_no=item.product_type_no, product_group_name=item.product_group_name,
                          graphical_appearance_no=item.graphical_appearance_no,
                          colour_group_code=item.colour_group_code,
                          department_no=item.department_no, index_code=item.index_code,
                          index_group_no=item.index_group_no,
                          section_no=item.section_no, garment_group_no=item.garment_group_no,
                          description=item.description,
                          price=item.price)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return True


def create_transactions(db: Session, transaction: schemas.Transactions):
    # create transaction
    db_transaction = models.Transactions(user_id=transaction.user_id, item_id=transaction.item_id,
                                         sales_channel_id=transaction.sales_channel_id, timestamp=get_current_time(),
                                         event_type=transaction.event_type)

    db.add(db_transaction)
    db.commit()
    db.refresh(db_transaction)
    return True




def get_items_by_item_id(db: Session, item_ids: List[str]):
    return db.query(models.Item).filter(or_(*[models.Item.item_id == id for id in item_ids])).all()

def get_transactions_for_item(db: Session , user_id: str):
    return db.query(models.Transactions).filter(models.Transactions.user_id == user_id).first()

def update_password(db: Session, email: str,update_items):
    db.query(models.User).filter(models.User.email == email).update(update_items)
    db.commit()

def suggest(db, query):
    result =  db.query(models.Item).filter(models.Item.product_name.like('%' + query + '%')).limit(50).distinct().all()
    items =  [item.product_name for item in result]
    return set(items)

