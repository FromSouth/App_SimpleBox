# App_SimpleBox

![Static Badge](https://img.shields.io/badge/Machine-pwnable-blue)
![Static Badge](https://img.shields.io/badge/LICENSE-MIT-green)

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

# 1. 功能簡介

* 提供一組Docker相關腳本，運行腳本後可建立簡單紅隊靶機，作為示範教學使用。

# 2. 項目介紹

## 2.1. Release Asset

- **data資料夾**：配合dockerfile設定所需檔案
- **dockerfile檔案**：容器創建文件
- **LICENSE檔案**：版權宣告
- **README.md檔案**：說明文件

## 2.2. 外部依賴

- **Ubuntu Image**：執行dockerfile組建所需，可為遠端dockerhub或本地提供
- **自訂義肢有弱點ELF檔案** : 供運行於指定port上進行BOF攻擊練習
# 3. 作業運用

## 3.1 Repo構管

* 此Repo為public，設定保護main branch。
* 主要更新於develop branch執行後，pull request回main branch。

## 3.2. 模組設計

* 於README.md及/doc/design.vpp說明。
* 主要規格為：
  * 可組建靶機容器映像檔
  * 靶機具備外部滲透弱點：Buffer overflow 漏洞
  * 靶機具備內部提權弱點：linux cp提權

## 3.3. 模組發展

### 3.3.1. 功能開發

* 主要編寫bash腳本用以初始化靶機，可下載Repo後使用VScode編寫。

### 3.3.2. 模組測試

* 使用Python的Pipenv虛擬環境+Pytest模組。
* 測試時：
  1. 安裝pipenv ```pip install pipenv```
  2. 回復pipenv ```pipenv install```
  3. 執行測試 ```pipenv run pytest```
* 省略未做單元測試，僅做黑箱模組測試。
* 測試個案為：
  1. 個案：**FTP**可遠端連線**BoxContainer**並具備存取權。
  2. 個案：**特定服務**可遠端連線**BoxContainer**。

### 3.3.3. 模組發佈

* 檢核後手動發佈
