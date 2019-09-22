#!/bin/bash

#INSTALACAO E CONFIGURAÇÃO DO PHP E XDEBUG
echo "Instalação PHP 5.6 7.0 7.1 E 7.2 com configuração do XDEBUG"
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update -y
sudo apt install -y php7.2 php7.2-fpm php7.1 php7.1-fpm php7.0 php7.0-fpm php5.6 php5.6-fpm
sudo apt install -y php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-bcmath php7.2-xml php7.2-zip php7.2-intl php7.2-soap php7.2-mysql php7.2-mysql
sudo apt install -y php7.1-curl php7.1-gd php7.1-json php7.1-mbstring php7.1-mcrypt php7.1.bcmath php7.1-xml php7.1-zip php7.1-intl php7.1-soap php7.1-mysql
sudo apt install -y php7.0-curl php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt php7.0 bcmath php7.0-xml php7.0-zip php7.0-intl php7.0-soap php7.0-mysql
sudo apt install -y php5.6-curl php5.6-gd php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-bcmath php5.6-xml php5.6-zip php5.6-intl php5.6-soap php5.6-mysql
sudo apt install -y php-xdebug

sudo su << SUDO_COMANDS
echo "xdebug.remote_enable=on" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_mode=req" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.idekey=phpstorm" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9001" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.max_nesting_level=400" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini

echo "xdebug.remote_enable=on" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_mode=req" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.idekey=phpstorm" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9001" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.max_nesting_level=400" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini

echo "xdebug.remote_enable=on" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_mode=req" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.idekey=phpstorm" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9001" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.max_nesting_level=400" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini

echo "xdebug.remote_enable=on" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=1" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_mode=req" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.idekey=phpstorm" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9001" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.max_nesting_level=400" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/5.6/fpm/conf.d/20-xdebug.ini
SUDO_COMANDS

#INSTALACAO OUTROS PROGRAMAS
sudo apt install -y nginx docker.io docker-compose wget silversearcher-ag composer guake git curl nano

#CONFIGURANDO GIT
read -p "Digite um E-mail para configurar os commits do git ( o mesmo utilizado na sua conta): " git_email
read -p "Digite o Nome que vai aparecer nos commits: " git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"

#INSTALACAO E CONFIGURACAO DO MYSQL
echo "Instalando o Mysql server e criando um usuário"
sudo apt install mysql-server -y
sudo mysql_secure_installation
sudo systemctl start mysql
echo "CRIANDO USUÁRIO DO MYSQL PARA CONEXÃO"
read -p "User: " user
read -s -p "Password: " pass
sudo mysql << MY_QUERY
CREATE USER '${user}'@'localhost' IDENTIFIED BY '${pass}';
GRANT ALL PRIVILEGES ON *.* TO '${user}'@'localhost';
FLUSH PRIVILEGES;
MY_QUERY
echo "User Created. "
sleep 3s;

#INSTALACAO VSCODE
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt-get update -y
sudo apt-get install code -y

#CONFIGURAÇÃO DOCKER
sudo usermod -aG docker $USER
echo "É NECESSÁRIO REINICIAR A MÁUINA PARA TERMINAR A INSTALAÇÃO DO DOCKER"
sleep 1s

#GERACAO CHAVE SSH
echo "-----Geração da Chave SSH -----"
if [ ! -f "/home/$USER/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -C "test@example.com" -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub
    echo "COPIE O CONTEÚDO E INSIRA NAS CONFIGURAÇÕES DE CHAVES SSH DO BITBUCKET [PRESSIONE QUALQUER TECLA PARA CONTINUAR]"
    read enter
else
    echo "A chave ssh já existe"
    echo "Ignorando essa etapa"
fi

#INSTALACAO JETBRAINS TOOLBOX
cd ~/Downloads
wget -O ~/Downloads/toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5796.tar.gz
mkdir ~/Downloads/Toolbox
tar xvzf toolbox.tar.gz -C ~/Downloads/Toolbox
sudo rm -r ~/Downloads/toolbox.tar.gz
cd ~/Downloads/Toolbox/jetbrains-toolbox-1.15.5796/
./jetbrains-toolbox

#INSTALAÇÃO CHROME
cd ~/Downloads/
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo rm -r ~/Downloads/chrome.deb

#INSTALAÇÃO N98 MAGERUN
curl -O https://files.magerun.net/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo mv ./n98-magerun.phar /usr/local/bin/

# #ISNTALAÇÃO N98 MAGERUN2
curl -O https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar
sudo mv ./n98-magerun2.phar /usr/local/bin/
