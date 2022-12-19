import os
import logging
import psycopg2
from dotenv import load_dotenv


load_dotenv(override=True)

logger = logging.getLogger('PARSER')
logger.setLevel(logging.INFO)

handler = logging.FileHandler(f'{__name__}.log', 'w')
formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)


class Config:
    """Класс с настройками"""
    userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ' \
                'Chrome/102.0.5005.63 Safari/537.36 '

    def __init__(self):
        self.NAME_DB = os.environ.get('name_db')
        self.USERNAME_DB = os.environ.get('user_DB')
        self.PASSWORD_DB = os.environ.get('password_DB')
        self.PORT = os.environ.get('port')
        self.HOST = os.environ.get('host')

    def make_con(self):
        return psycopg2.connect(dbname=self.NAME_DB,
                                user=self.USERNAME_DB,
                                password=self.PASSWORD_DB,
                                host=self.HOST,
                                port=self.PORT)


config = Config()