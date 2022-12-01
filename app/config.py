import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

load_dotenv(override=True)


class Config:
    """Класс с настройками"""
    userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36'

    def __init__(self):
        Session = sessionmaker()
        self.USERNAME_DB = os.environ.get('user_DB')
        self.PASSWORD_DB = os.environ.get('password_DB')
        self.engine = create_engine(f'postgresql://{self.USERNAME_DB}:{self.PASSWORD_DB}@localhost/flats', echo=False)
        Session.configure(bind=self.engine)
        self.Base = declarative_base()
        self.session = Session()


config = Config()