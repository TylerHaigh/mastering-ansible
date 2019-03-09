import pymysql
pymysql.install_as_MySQLdb()

from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy

# mysql_db_url = 'mysql://tyler:tylerlocalhost@192.168.60.6/demo?auth_plugin=mysql_native_password'
# mysql_db_url = 'mysql+pymysql://tyler:tylerlocalhost@192.168.60.6/demo?auth_plugin=mysql_native_password'
mysql_db_url = 'mysql://tyler:tylerlocalhost@192.168.60.6/demo'


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = mysql_db_url

db = SQLAlchemy(app)
db.create_all()