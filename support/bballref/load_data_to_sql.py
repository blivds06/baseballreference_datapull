import pyodbc
from sqlalchemy import event
import urllib.request
import sqlalchemy
from bballref.config import config


class sql_engine_object:
    def __init__(self):
        sqlconn = pyodbc.connect(config.sqlsvr)
        self.cursor = sqlconn.cursor()

    def engine(self):
        params = config.sqlsvr
        db_params = urllib.parse.quote_plus(params)
        engine = sqlalchemy.create_engine(
            "mssql+pyodbc:///?odbc_connect={}".format(db_params)
        )
        return self.cursor, engine

    def close_cursor(self):
        self.cursor.close()
