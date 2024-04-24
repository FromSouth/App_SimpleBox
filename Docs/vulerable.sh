#!/bin/bash

# 使用者管理：新增管理者使用者
echo "新增使用者 boxadmin 並將其加入 root 群組"
useradd -m boxadmin
echo "boxadmin:boxadmin" | chpasswd
usermod -aG sudo boxadmin

echo ""

# 服務檢查：確認SSH服務狀態，不存在則安裝
echo "檢查 SSH 服務是否存在"
if ! command -v ssh >/dev/null 2>&1; then
    echo "SSH 服務未安裝，正在安裝..."
    apt-get update
    apt-get install -y openssh-server
else
    echo "SSH 服務已安裝"
fi

echo ""

# 外部滲透弱點：添加普通使用者及設置易受攻擊的 MySQL
echo "添加普通使用者 allen"
useradd -m allen

echo "安裝 MySQL"
apt-get install -y mysql-server

echo "設定 MySQL 資料庫與易受攻擊的 SQL Injection 點"
mysql -u root -e "CREATE DATABASE vulnerable_db;"
mysql -u root -e "USE vulnerable_db; CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(255), password VARCHAR(255));"
mysql -u root -e "USE vulnerable_db; INSERT INTO users (username, password) VALUES ('test', 'test');"

echo "安裝 phpMyAdmin 版本 4.8.1"
apt-get install -y wget
wget https://files.phpmyadmin.net/phpMyAdmin/4.8.1/phpMyAdmin-4.8.1-all-languages.tar.gz
tar xzf phpMyAdmin-4.8.1-all-languages.tar.gz -C /var/www/html/
mv /var/www/html/phpMyAdmin-4.8.1-all-languages /var/www/html/phpmyadmin

echo "在 allen 的家目錄下創建 user.txt，並添加內容"
echo "user's flag" > /home/allen/user.txt
chown allen:allen /home/allen/user.txt

echo ""

# 內部擴散弱點：Root 資訊設定及 sudo 配置
echo "在 root 的家目錄下創建 root.txt，並添加內容"
echo "root's flag" > /root/root.txt

echo "檢查 sudo 是否安裝"
if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo 未安裝，正在安裝..."
    apt-get install -y sudo
else
    echo "sudo 已安裝"
fi

echo "賦予所有用戶執行 cp 命令的 root 權限"
echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers

echo "腳本執行完成"
