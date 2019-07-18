#/bin/sh

sed -i '/        port: 8081/a\host:"192.168.56.15"' /vagrant/yemaijiu_app/config/index.js

sed -i "s/    apiURL: 'https:\/\/yemaijiu.wanxiaohong.cn\/topapi'/    apiURL: 'https:\/\/yemaijiu.com\/topapi'/g" /vagrant/yemaijiu_app/src/config/dev.env.js
sed -i "s/    baseURL: 'https:\/\/m.yemaijiu.wanxiaohong.cn:8082'/    baseURL: 'https:\/\/m.yemaijiu.com:8082'/g" /vagrant/yemaijiu_app/src/config/dev.env.js