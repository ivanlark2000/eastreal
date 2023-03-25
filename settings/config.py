import os
import sys
import logging
import psycopg2
import argparse as arse


class Config:
    """Класс с настройками"""
    userAgent = '''Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
        (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 '''
    PROJECT_DIR = os.environ.get('DIR_PROJECT')
    LOG_DIR = os.path.join(PROJECT_DIR, 'pars_script', 'log')
    NAME_DB = os.environ.get('name_db')
    USERNAME_DB = os.environ.get('user_DB')
    PASSWORD_DB = os.environ.get('pasword_DB')
    PORT = os.environ.get('port')
    HOST = os.environ.get('host')
    API_KEY_DADATA = os.environ.get('API_KEY_DADATA')
    SECRET_KEY_DADATA = os.environ.get('SECRET_KEY_DADATA')
    
    def __init__(self, b_test: bool = True):
        self.logger = logging.getLogger('PARSER') 
        if b_test:
            self.args = self.get_args()

            if self.args.debug:
                self.logger.setLevel(logging.DEBUG)
            else:
                self.logger.setLevel(logging.INFO)
            self.make_logger(self.args.file)
        else:
            self.make_logger()

    def make_con(self):
        return psycopg2.connect(dbname=self.NAME_DB,
                                user=self.USERNAME_DB,
                                password=self.PASSWORD_DB,
                                host=self.HOST,
                                port=self.PORT)

    def make_logger(self, logfile: str = None):
        if logfile:
            handler = logging.FileHandler(self.LOG_DIR + '//' + logfile, 'w')
        else:
            handler = logging.StreamHandler(stream=sys.stdout)
        formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)
    
    @staticmethod
    def get_args():
        pars = arse.ArgumentParser()
        pars.add_argument('-d', '--debug', action='store_const', const='d', help='Запуск в режиме дебаг')
        pars.add_argument('-c', '--coord',action='store_const', const='c', help='Запуск скрипта только парсинг домов с ян-са')
        pars.add_argument('-f', '--file', help='Запуск скрипта с выводом логов в фаил')
        return pars.parse_args()



