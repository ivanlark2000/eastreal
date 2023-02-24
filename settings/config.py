import os
import sys
import logging
import psycopg2
import argparse

class Config:
    """Класс с настройками"""
    userAgent = '''Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
        (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 '''
    PROJECT_DIR = os.environ.get('DIR_PROJECT')
    LOG_DIR = os.path.join(PROJECT_DIR, 'pars_script', 'log')
    NAME_DB = os.environ.get('name_db')
    USERNAME_DB = os.environ.get('user_DB')
    PASSWORD_DB = os.environ.get('password_DB')
    PORT = os.environ.get('port')
    HOST = os.environ.get('host')
    API_KEY_DADATA = os.environ.get('API_KEY_DADATA')
    SECRET_KEY_DADATA = os.environ.get('SECRET_KEY_DADATA')
    logger = logging.getLogger('PARSER') 
    logger.setLevel(logging.INFO)

    def make_con(self):
        return psycopg2.connect(dbname=self.NAME_DB,
                                user=self.USERNAME_DB)
                                #,
                                #password=self.PASSWORD_DB,
                                #host=self.HOST,
                                #port=self.PORT)
    
    def make_logger_term(self):
        handler = logging.StreamHandler(stream=sys.stdout)
        formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)
        return self.logger

    def make_logger(self, logfile: str):
        handler = logging.FileHandler(self.LOG_DIR + '//' + logfile, 'w')
        formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)
        return self.logger


parser = argparse.ArgumentParser()
parser.add_argument('-t', '--terminal', help='Запуск парсера с выводом логов в консоль')
parser.add_argument('-f', '--file', help='Запуск скрипта с выводом логов в фаил')
args = parser.parse_args()

config = Config()


if args.file:
    logger = config.make_logger(args.file)
else:
    logger = config.make_logger_term()
