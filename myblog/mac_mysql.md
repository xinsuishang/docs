# mysql
---
```
// 旧版本删除
ps -ax | grep mysql
#stop and kill any MySQL processes
brew remove mysql
brew cleanup
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
launchctl unload -w~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
edit /etc/hostconfig and remove the line MYSQLCOM=-YES-
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*
```

```
$ brew install mysql
// 设置密码
$ cd /usr/local/bin
$ ./mysqld_safe --skip-grant-tables &
$ mysql.service start
$ mysql
mysql>FLUSH PRIVILEGES;
mysql>ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';

// 查看端口
mysql>show global variables like 'port';

//如果端口为0
$ mysql.service stop
$ cd /usr/local/Cellar/mysql/8.0.18_1
$ vi homebrew.mxcl.mysql.plist
// 在ProgramArguments下添加
<string>--port=3306</string>
$ mysql.service start
```