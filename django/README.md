# django enviroment

## Description
django の環境の雛形。
.env に指定した django プロジェクトのサーバーを立ち上げる。
指定した プロジェクト名の django のプロジェクトが存在しない場合は新しくプロジェクトを作成する。
django + nginx + postgres + gunicorn で動いている。
nginx でリバースプロキシしているので、外からは nginx の port でアクセスする。

## Build

settings.py の中身の　ALLOWED_HOSTS を　["*"] にするとすべてのホストからアクセスできる

- release 用 コンテナ立ち上げ
```shell
docker-compose build && docker-compose up -d
```

- dev 用サーバー立ち上げ 
(release 用コンテナだとファイルの更新が反映されない)
先に release 用コンテナを立ち上げておく。
(そうすると、開発中のデータベースの変更が release 用の db に保存される)
settings.py の DATABASE の HOST を 'localhost' にして以下のコマンドを実行
```shell
# host machine に postgresql をインストール
sudo apt install postgresql

# サーバー立ち上げ
cd <path>/<to>/<project_root>
python manage.py runserver [ip:port]
# (docker 上で runserver してもうまく動いてくれない、、、)
# ip に 0 を設定するとすべてのipからのリクエストを受け付ける、port は default は 8000
```

- 新しく app を作成
```shell
docker exec <container_name> django-admin startapp <appname>
```
- model の merge
```shell
docker exec <container_name> python manage.py makemigrations
docker exec <container_name> python manage.py migrate
```

## Settings

- .env の default の中身
```shell
DJANGO_PORT=3333 # この値を変更したら nginx/nginx.conf の　upstream django_server の値も変更する
DJANGO_PROJECT_NAME=project_x # django の project 名
DJANGO_APP_PATH=work/django # ${HOME} 以下のdjango のプロジェクトを作成（存在）するディレクトリ
NGINX_PORT=8080
POSTGRES_PORT=5432
```
