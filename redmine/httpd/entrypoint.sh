#!/bin/sh
set -e

cd /var/lib/redmine
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake redmine:plugins:migrate
RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data

cd

# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

exec httpd -DFOREGROUND "$@"
    
