
# https://stackoverflow.com/a/2101706/2442468
# https://stackoverflow.com/a/52579886/2442468
sudo service mysqld stop
sudo mysqld_safe --skip-grant-tables &
sudo mysql -u root

mysql> use mysql;
mysql> flush privileges;
# NOTE: UPDATE / ALTER does not work!!! You have to drop and re-create
mysql> DROP USER 'tyler'@'localhost' ;

# https://dev.mysql.com/doc/refman/8.0/en/validate-password.html
# https://dev.mysql.com/doc/refman/8.0/en/validate-password-options-variables.html
# LOW policy tests password length only. Passwords must be at least 8 characters long.
mysql> SET GLOBAL validate_password.policy = 0; 
mysql> SHOW VARIABLES LIKE 'validate_password.%';
mysql> Create USER 'tyler'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tylerlocalhost';
mysql> Create USER 'tyler'@'192.168.60.4' IDENTIFIED WITH mysql_native_password BY 'tylerlocalhost';

mysql> GRANT ALL PRIVILEGES ON *.* TO 'tyler'@'localhost';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'tyler'@'192.168.60.4';

mysql> flush privileges;
mysql> quit

sudo service mysqld stop
sudo service mysqld start
echo "done"

## https://github.com/geerlingguy/drupal-vm/issues/650
# sudo mysql
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

