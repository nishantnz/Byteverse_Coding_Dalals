from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.dialects.mysql import BIGINT, JSON
from databases.database import Base


class User(Base):
    __tablename__ = "users"
    user_id = Column(String(100), index=True)
    name = Column(String(100))
    email = Column(String(50), unique=True, primary_key=True, index=True)
    hashed_password = Column(String(40))
    club_member_status = Column(String(40))
    fashion_news_frequency = Column(String(40))
    age = Column(Integer)
    postal_code = Column(String(100))


class Item(Base):
    __tablename__ = "items"

    item_id = Column(BIGINT, primary_key=True, index=True, autoincrement=False)
    product_name = Column(String(2000))  
    product_type_no = Column(BIGINT)
    product_group_name = Column(String(2000))
    graphical_appearance_no = Column(BIGINT)
    colour_group_code = Column(BIGINT)
    department_no = Column(BIGINT)
    index_code = Column(String(2000))
    index_group_no = Column(BIGINT)
    section_no = Column(BIGINT)
    garment_group_no = Column(BIGINT)
    description = Column(String(2000))
    price = Column(String(2000))


class Transactions(Base):
    __tablename__ = "transactions"
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column(String(100), ForeignKey("users.user_id"), index=True)
    item_id = Column(BIGINT, ForeignKey("items.item_id"))
    sales_channel_id = Column(BIGINT)
    timestamp = Column(BIGINT)
    event_type = Column(String(20))


class Cart(Base):
    __tablename__="cart"
    user_id = Column(String(100), index=True,primary_key=True)
    item_ids = Column(JSON)