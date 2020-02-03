# django enviroment

## Description
django の環境の雛形。
.env に指定した django プロジェクトのサーバーを立ち上げる。
指定した プロジェクト名の django のプロジェクトが存在しない場合は新しくプロジェクトを作成する。
django + nginx + postgres + gunicorn で動いている。
nginx でリバースプロキシしているので、外からは nginx の port でアクセスする。

## Build

- コンテナ立ち上げ
```shell
docker-compose build && docker-compose up -d
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
