kill -9 `cat tmp/pids/server.pid`
secret=`rake secret`
export SECRET_KEY_BASE=$secret
RAILS_ENV=production rails s -b BIND_IP -p BIND_PORT -d
