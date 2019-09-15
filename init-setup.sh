#!/bin/bash

#INSTALACAO E CONFIGURAÇÃO DO PHP E XDEBUG
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install -y php7.2 php7.2-fpm php7.1 php7.1-fpm php7.0 php7.0-fpm php5.6 php5.6-fpm
sudo apt install -y php7.2-curl php7.2-gd php7.2-json php7.2-mbstring
sudo apt install -y php7.1-curl php7.1-gd php7.1-json php7.1-mbstring php7.1-mcrypt
sudo apt install -y php7.0-curl php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt
sudo apt install -y php-xdebug
sudo echo "xdebug.remote_enable=on" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_autostart=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_mode=req" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.idekey=phpstorm" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_port=9001" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.max_nesting_level=400" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini

sudo echo "xdebug.remote_enable=on" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_autostart=1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_mode=req" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.idekey=phpstorm" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_port=9001" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.max_nesting_level=400" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini

sudo echo "xdebug.remote_enable=on" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_autostart=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_mode=req" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.idekey=phpstorm" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_port=9001" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.max_nesting_level=400" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini

sudo echo "xdebug.remote_enable=on" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_autostart=1" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_mode=req" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.idekey=phpstorm" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_port=9001" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.max_nesting_level=400" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo echo "xdebug.remote_host=127.0.0.1" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini



#INSTALACAO OUTROS PROGRAMAS
sudo apt install -y nginx docker.io wget silversearcher-ag composer guake

#INSTALACAO E CONFIGURACAO DO MYSQL
sudo apt install mysql-server
echo CRIANDO USUÁRIO DO MYSQL PARA CONEXÃO
read -p "Nome do Usuário: " user
read -p -s "Senha: " pass
sleep 1
sudo mysql << MY_QUERY
CREATE USER '${user}'@'localhost' IDENTIFIED BY '${pass}';
GRANT ALL PRIVILEGES ON *.* TO '${user}'@'localhost';
FLUSH PRIVILEGES;
MY_QUERY
echo Usuário criado. Informações de Acesso:
echo User: $user
echo Senha: $pass
sleep 3s;

#INSTALACAO VSCODE
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt-get update
sudo apt-get install code


#CONFIGURAÇÃO DOCKER
sudo usermod -aG docker $USER
echo É NECESSÁRIO REINICIAR A MÁUINA PARA TERMINAR A INSTALAÇÃO DO DOCKER
sleep 1s

#GERACAO CHAVE SSH
echo -----Geração da Chave SSH -----
ssh-keygen -t rsa -b 4096 -C "test@example.com" -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
echo COPIE O CONTEÚDO E INSIRA NAS CONFIGURAÇÕES DE CHAVES SSH DO BITBUCKET [PRESSIONE ENTER PARA CONTINUAR]
read enter

#INSTALACAO JETBRAINS TOOLBOX
cd ~/Downloads
wget -O ~/Downloads/toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5796.tar.gz
mkdir ~/Downloads/Toolbox
tar xvzf toolbox.tar.gz -C ~/Downloads/Toolbox
#echo Para executar o Toolbox e baixar o PhpStorm basta acessar a pasta /Downloads/Toolbox/jetbrains-toolbox-1.15.5796 e rodar o arquivo que está dentro da mesma.
#sleep 5
cd ~/Downloads/Toolbox/jetbrains-toolbox-1.15.5796/
./jetbrains-toolbox

#INSTALAÇÃO CHROME
cd ~/Downloads/
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb



