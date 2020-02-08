FROM debian:buster
MAINTAINER aqlzim ayoub <aaqlzim@student.1337.ma>
COPY srcs/default usr/bin/default
COPY srcs/config.inc.php usr/bin/config.inc.php
COPY srcs/default1 usr/bin/default1
COPY srcs/wp-config.php usr/bin/wp-config.php
COPY srcs/setup.sh usr/bin/setup.sh
CMD bash setup.sh
