import os 
import sys
import logging
from unittest import (
        TestCase,
        main
    )

sys.path.insert(1, '/home/lark/project/eastreal/settings')

from config import Config 


class TestConfig(TestCase):

    def setUp(self):
        self.config = Config(b_test=False)
    
    def test_db_connection(self):
        """
        Тестирование соединения к базе 
        """
        con = self.config.make_con()
        self.assertTrue(con.status == 1)
    
    def test_make_logger(self):
        """
        Тестирование создания логеров  с выводом в консоль и в файл
        """
        handler1 = type(self.config.logger.handlers[0]).__name__
        self.config.logger.handlers = []
        self.config.make_logger('teat.log')
        handler2 = type(self.config.logger.handlers[0]).__name__
        self.assertTrue(
                handler1 == 'StreamHandler' and handler2 == 'FileHandler'
                )

    def tearDawn(self):
        os.remove(self.config.LOG_DIR + '//' + 'test.log')


if __name__ == "__main__":
    main()
