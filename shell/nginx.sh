#!/bin/bash

mkdir -p /vagrant/logs/

sed -i 's/#error_log  logs\/error\.log  notice;/error_log  \/vagrant\/logs\/error\.log  error;/g' /usr/local/nginx/conf/nginx.conf;
sed -i 's/listen       80;/listen       8080;/g' /usr/local/nginx/conf/nginx.conf;
echo 'server {
      	listen       80;
      	listen       443;
      	server_name  yemaijiu.com;
      	root	"/vagrant/public";
      	ssl on;
        ssl_certificate /vagrant/yemaijiu/yemaijiu_app/cert/server.crt;
        ssl_certificate_key /vagrant/yemaijiu/yemaijiu_app/cert/server.key;
      	index  index.php index.html index.htm;
        add_header "Access-Control-Allow-Origin" "http://m.yemaijiu.com";
        add_header "Access-Control-Allow-Methods" "OPTIONS";
        add_header "Access-Control-Allow-Credentials" true;
        add_header "Access-Control-Allow-Headers" "content-type";
        if ($request_method = 'OPTIONS') {
            return 200;
        }
       location / {
           try_files $uri /index.php?$args;
       }
       location ~ \.php(.*)$  {
            fastcgi_pass   192.168.56.12:9000;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
	    }
        access_log  /vagrant/logs/yemaijiu.com.log;

      }' > /usr/local/nginx/conf/conf.d/www.conf;
echo 'server {
        listen       80;
        listen       443;
        ssl on;
        ssl_certificate /vagrant/yemaijiu/yemaijiu_app/cert/server.crt;
        ssl_certificate_key /vagrant/yemaijiu/yemaijiu_app/cert/server.key;
        server_name  m.yemaijiu.com;
        root	"/vagrant/";
        index  index.html index.htm;

     location / {
        try_files $uri $uri/ /index.html;
        #proxy_pass https://192.168.56.15:8082;
     }
      access_log  /vagrant/logs/m.yemaijiu.com.log;

    }' > /usr/local/nginx/conf/conf.d/m.conf;