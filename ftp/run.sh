#!/bin/sh

docker run -d \
-v /home/ftp:/home/vsftpd \
-p 20:20 \
-p 21:21 \
-e FTP_USER=admin -e FTP_PASS=123456 \
-e PASV_ADDRESS=59.110.213.203 \
--name docker-vsftpd \
--restart=always fauria/vsftpd