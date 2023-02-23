import os
import psycopg2


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
    
    def __init__(self, logname: str):
        self.logger = self.make_logger(logname)

    def make_con(self):
        return psycopg2.connect(dbname=self.NAME_DB,
                                user=self.USERNAME_DB)
                                #,
                                #password=self.PASSWORD_DB,
                                #host=self.HOST,
                                #port=self.PORT)
    
    def make_logger(self, logfile: str):
        import logging
        logger = logging.getLogger('PARSER') 
        logger.setLevel(logging.INFO)
        handler = logging.FileHandler(self.LOG_DIR + '//' + logfile, 'w')
        formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        return logger
