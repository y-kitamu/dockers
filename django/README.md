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

- dev 用サーバー立ち上げ (release 用コンテナだとファイルの更新が再起動時しか反映されない)
```shell
docker-compose -f docker-compose.dev.yml -d
```

- 新しく app を作成
```shell
docker exec <container_name> django-admin startapp <appname>
```
<project_name>/settings.py の INSTALLED_APPS に追記
```python settings.py
~
INSTALLED_APPS = [
    '<appname>.apps.<Appname>Config',
    ...
]
~
~
```

- model の merge
```shell
docker exec <container_name> python manage.py makemigrations
docker exec <container_name> python manage.py migrate
```

- admin 画面を使用する
```shell
# super user の作成
python manage.py createsuperuser
```

```python admin.py
from models import <ModelName>

# モデルを admin 画面から編集できるようにする追加
admin.site.register(<ModelName>)

~
```

## Settings

- .env の default の中身
```shell
DJANGO_PORT=3333 # この値を変更したら nginx/nginx.conf の　upstream django_server の値も変更する
DJANGO_PROJECT_NAME=project_x # django の project 名
DJANGO_APP_PATH=work/django # ${HOME} 以下のdjango のプロジェクトを作成（存在）するディレクトリ
NGINX_PORT=8080 # release 用のサーバーの場合、この port にアクセスすると reverse proxy で django に redirect される
POSTGRES_PORT=5432
```
