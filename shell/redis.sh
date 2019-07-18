#!/bin/sh
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar zxvf redis-5.0.5.tar.gz
cd redis-5.0.5
make && make install
mkdir -p /usr/local/redis/bin/
cp /home/vagrant/redis-5.0.5/src/{redis-benchmark,redis-check-aof,redis-check-rdb,redis-cli,redis-sentinel,redis-server} /usr/local/redis/bin/
echo '
protected-mode no
port 6379
timeout 0
tcp-keepalive 300
daemonize yes
pidfile /var/run/redis_6379.pid
loglevel notice
logfile "/var/log/redis_6379.log"
databases 16
save 900 1
save 300 10
save 60 10000
dbfilename dump.rdb
dir /usr/local/redis/
' > /usr/local/redis/redis.conf
echo '
#!/bin/bash
#shebang机制
#Startup script for the redus service.
# chkconfig:2345 85 20
# description: redis is programme
#
redis=/usr/local/redis/bin/redis-server
config=/usr/local/redis/redis.conf
pid=/var/run/redis_6379.pid
RETYAL=0
prog="redis-server"

. /etc/rc.d/init.d/functions
#Source network configuration.
. /etc/sysconfig/network
#Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0
[ -x $redis ] || exit 0

start() {
    [ -x $redis ] || \
        { echo "FATAL: No such programme";exit 4; }
    [ -f $config ] || \
	{ echo "FATAL: Config file does not exist";exit 6; }
    if [ -e $pid ];then
        echo $"$prog already running...."
        exit 1
    fi
    echo -n $"Starting $prog services:"
    $redis $config
    RETVAL=$?
    [ $RETVAL=0 ] && success
    echo
    return $RETVAL
}

stop() {
    echo -n $"Stoping $prog services:"
    killproc -p $pid
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -rf $pid
}

test() {
    echo
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    test)
        configtest
        ;;
    restart)
        stop
        start
        ;;
    status)
        status $prog
        RETVAL=$?
        ;;
    *)
        echo $"Usage:$prog{start|stop|restart|test|status|help}"
        exit 1
esac
exit $RETVAL
'> /usr/local/redis/bin/redis.server
chmod +x /usr/local/redis/bin/redis.server
ln -s /usr/local/redis/bin/redis.server /etc/init.d/redis
chkconfig --add redis