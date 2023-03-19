import sys
from unittest import (
        TestCase,
        main
    )

sys.path.insert(1, '/home/lark/project/eastreal/settings')

from config import Config 


class TestBase(TestCase):

    def setUp(self):
        self.config = Config()
    
    def test_db_connection(self):
        con = self.config.make_con()
        self.assertTrue(con.status == 1)


if __name__ == "__main__":
    main()

