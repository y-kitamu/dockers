FROM httpd:latest

# http://blog.redmine.jp/articles/3_4/install/ubuntu/
MAINTAINER Yusuke Kitamura

RUN sed -i \
    -e 's/^#ServerName www.example.com:80/ServerName redmine/' \
    -e 's/^#\(Include .*httpd.ssl.conf\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    conf/httpd.conf

RUN apt-get update && apt-get install -y \
    subversion \
    ruby \
    ruby-dev \
    build-essential \
    liblzma-dev \
    patch zlib1g-dev \
    libpq-dev pkg-config \
    libmagick++-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    procps

RUN apt-get update && apt-get upgrade -y

RUN gem install bundler --no-rdoc --no-ri && gem install nokogiri && gem install pg
RUN svn co http://svn.redmine.org/redmine/branches/4.0-stable /var/lib/redmine

COPY config/database.yml /var/lib/redmine/config/
COPY config/configuration.yml /var/lib/redmine/config/

RUN cd /var/lib/redmine && \
    bundle install --without development test --path vendor/bundle &&\
    bundle exec rake generate_secret_token

RUN gem install passenger -v 6.0.2 --no-rdoc --no-ri &&\
    passenger-install-apache2-module --auto --languages ruby

# 上のインストールで openssl 関係のファイルが上書きされてしまい（？）エラーがでたので、修正
RUN sed -i 's/\(CipherString = DEFAULT@SECLEVEL=\)2/\11/' /etc/ssl/openssl.cnf 

RUN sed -i 's/^DocumentRoot ".*htdocs"/DocumentRoot "\/var\/lib\/redmine\/public"/' conf/httpd.conf
RUN echo "Include conf/redmine.conf" >> conf/httpd.conf &&\
    echo "Include conf/ssl.conf" >> conf/httpd.conf

RUN mkdir -p /var/log/apache2

# http://www.redmine.org/projects/redmine/wiki/RedmineInstall#Step-8-File-system-permissions
# 755 だとうまく行かなかったので、応急処置的に 777 にした
RUN cd /var/lib/redmine/ &&\
    mkdir -p tmp tmp/pdf public/plugin_assets &&\
    chmod -R 777 files log tmp public/plugin_assets

COPY cert/server.crt /usr/local/apache2/conf/
COPY cert/server.key /usr/local/apache2/conf/
COPY ssl.conf /usr/local/apache2/conf/
# TODO: リダイレクトの設定
COPY redmine.conf /usr/local/apache2/conf/

# COPY entrypoint.sh /opt/
# RUN chmod +x /opt/entrypoint.sh

# ENTRYPOINT /opt/entrypoint.sh
