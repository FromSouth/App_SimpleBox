# 目的 

## 未來運用構想：
  I want to set a simple vulnerable ubuntu box for cyber security class.

## 擬請ChatGPT提供：
  please provide a bash script that can set the vulnerabilities in a given Ubuntu.

# 需求項目

## 提供操作說明：
  - how to run this bash script step by step.
  - box admin can management this box via ssh

## 設定基本功能：
  - add a new user "boxadmin" .   And add boxowner to root group.
  - change admin's password to plaintext "boxadmin". Ex. echo "boxadmin:boxadmin" | chpasswd.
  - check whether ssh service exists. if ssh not exist, install it.
    
## 設定外部滲透弱點：
  - add a new user, allen, who is a regular user.
  - set up a mysql database, which included an  easy sql injection exploit.
  - set up a phpmyadmin, version 4.8.1
  - the exploit should be found easy
  - In allen's home directory create a new file, named user.txt. And add a string "user's flag" to the file.

## 設定內部擴散弱點：
  * In root's home directory create a new file, named root.txt. And add a string "root's flag" to the file.
  * check whether sudo function exists. if sudo not exist, install it.
  * authorize all users the privilege that can execute cp command with root privileged.

# ChatGPT回復格式

## 注意事項：
  * do not assume that any work or any download and setup steps have been completed
  * segment  code exactly according what I mention in  [# 需求項目]
  * echo empty line between segments.
  * This script will be run in Ubuntu container by root, don't use sudo.
  * This script will be run in Ubuntu container with only core functions, use core commands only.
  * do the work step by step.make it easy to understand for students.
  * use limited echo lines with traditional Chinese I show you in following reference.
  
