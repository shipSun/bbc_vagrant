Vagrant.configure("2") do |config|
    config.vm.define "php5.6.40" do | php5 |
        php5.vm.box="php5.6.40"
        php5.vm.hostname = "php5"
        php5.vm.network "private_network", ip: "192.168.56.12"
        php5.vm.provider "virtualbox" do | vb |
            vb.memory = "1024"
            vb.cpus = 1
        end
        php5.vm.provision "shell", path: "shell/php.sh"
        php5.vm.provision "shell", inline: "service php-fpm start", run: "always"
    end
    config.vm.define "nginx" do | nginx |
        nginx.vm.box="nginx"
        nginx.vm.hostname="nginx"
        nginx.vm.network "private_network", ip: "192.168.56.13"
        nginx.vm.provider "virtualbox" do | vb |
            vb.memory="512"
            vb.cpus=1
        end
        nginx.vm.network "forwarded_port", guest: 80, host: 80
        nginx.vm.network "forwarded_port", guest: 443, host: 443
        nginx.vm.provision "shell", path: "shell/nginx.sh"

        nginx.vm.provision "shell", inline: "service nginx start", run: "always"

    end
    config.vm.define "redis" do | redis |
            redis.vm.box="centos-6.7"
            redis.vm.hostname="redis"
            redis.vm.network "private_network", ip: "192.168.56.14"
            redis.vm.provider "virtualbox" do | vb |
                vb.memory="512"
                vb.cpus=1
            end
            #redis.vm.provision "shell", inline: "service redis start", run: "always"
    end
    config.vm.define "node" do | node |
            node.vm.box="centos-6.7"
            node.vm.hostname="node"
            node.vm.network "private_network", ip: "192.168.56.15"
            node.vm.provider "virtualbox" do | vb |
                vb.memory="512"
                vb.cpus=1
            end
			#node.vm.provision "shell", path: "shell/h5.sh"
            #redis.vm.provision "shell", inline: "service redis start", run: "always"
    end
end
