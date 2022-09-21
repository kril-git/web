#!/bin/bash

WORK_DIR_STEPIK="/home/box"
PROJECT_DIR_STEPIK="$WORK_DIR_STEPIK/web"

WORK_DIR_HOME="/home/kril"
PROJECT_DIR_HOME="$HOME/web"

case "$1" in 
	init) 
		case "$2" in
			home)	
				echo $1 $2 $PROJECT_DIR_HOME $PROJECT_DIR_HOME/etc/nginx.conf
				echo
				sudo ls $PROJECT_DIR_HOME/etc/nginx.conf
				sudo ln -sf $PROJECT_DIR_HOME/etc/nginx.conf /etc/nginx/sites-enabled/nginx.conf

				sudo rm -rf /etc/nginx/sites-enabled/default
				sudo /etc/init.d/nginx stop
				sudo /etc/init.d/nginx start
				gunicorn -c /home/kril/web/etc/hello.py hello:app &
			;;
			*)
				sudo ln -sf $PROJECT_DIR_STEPIK/etc/nginx.conf /etc/nginx/sites-enabled/nginx.conf
				sudo ln -sf /home/box/web/etc/hello.py /etc/gunicorn.d/test
				sudo rm -rf /etc/nginx/sites-enabled/default
				sudo /etc/init.d/nginx stop
				sudo /etc/init.d/nginx start
				gunicorn -c /home/box/web/etc/hello.py hello:app &
			;;
		esac
	;;
	start)
		sudo /etc/init_d/nginx start
	;;
	restart)
		sudo /etc/init_d/nginx restart
	;;
	stop)
		sudo /etc/init_d/nginx stop
	;;
	*)
		echo "Usage: $0 {init|start|stop|restart}" >&2
		exit 1
	;;
esac
#sudo ln -sf /home/box/web/etc/nginx.conf  /etc/nginx/sites-enabled/default
#sudo /etc/init.d/nginx restart

