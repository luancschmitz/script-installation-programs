#!/bin/bash

#INSTALACAO E CONFIGURAÇÃO DO PHP E XDEBUG
echo "Instalação PHP 7.3 com configuração do XDEBUG"
sleep 2s
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update -y
sudo apt install -y php7.3 php7.3-fpm
sudo apt install -y php7.3-curl php7.3-gd php7.3-json php7.3-mbstring php7.3-bcmath php7.3-xml php7.3-zip php7.3-intl php7.3-soap php7.3-mysql
sudo apt install -y php-xdebug

sudo su << SUDO_COMANDS
echo "xdebug.remote_enable=on" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_autostart=1" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_mode=req" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.idekey=phpstorm" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_port=9001" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.max_nesting_level=400" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
echo "xdebug.remote_host=127.0.0.1" >> /etc/php/7.3/fpm/conf.d/20-xdebug.ini
SUDO_COMANDS

#INSTALACAO OUTROS PROGRAMAS
sudo apt install -y nginx wget silversearcher-ag guake git curl nano apt-transport-https ca-certificates gnupg-agent software-properties-common

#INSTALL DOCKER
echo "Installing Docker"
sleep 2s
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
cat /etc/os-release
read -p "INFORME O NONE DO UBUNTU_CODENAME DO TEXTO ACIMA: " codename
sudo su << SUDO_COMANDS
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${codename} stable" >> /etc/apt/sources.list
SUDO_COMANDS
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

#INSTALL DOCKER-COMPOSE
echo "Installing Docker Compose"
sleep 2s
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

#INSTALL COMPOSER
echo "Installing Composer"
sleep 2s
cd /home/$USER
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --filename=composer
sudo su << SUDO_COMANDS
chmod +x composer
mv composer /usr/local/bin
SUDO_COMANDS
php -r "unlink('composer-setup.php');"

#NNSTALL PRESTISSIMO DOWNLOADS PACKAGES IN PARALLEL
composer global require hirak/prestissimo

#CONFIGURANDO GIT
read -p "Digite um E-mail para configurar os commits do git ( o mesmo utilizado na sua conta): " git_email
read -p "Digite o Nome que vai aparecer nos commits: " git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"

#INSTALACAO E CONFIGURACAO DO MYSQL
echo "Instalando o Mysql server e criando um usuário"
sleep 2s
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
echo "Installing VSCODE"
sleep 2s
cd ~/Downloads/
wget -O vscode.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo dpkg -i vscode.deb
sudo rm -r ~/Downloads/vscode.deb

#GERACAO CHAVE SSH
echo "-----Geração da Chave SSH -----"
sleep 2s
if [ ! -f "/home/$USER/.ssh/id_rsa" ]; then
    read -p "Digite um E-mail para configurar a chave ssh: " ssh_email
    ssh-keygen -t rsa -b 4096 -C "$ssh_email" -N "" -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub
    echo "COPIE O CONTEÚDO E INSIRA NAS CONFIGURAÇÕES DE CHAVES SSH DO BITBUCKET [PRESSIONE QUALQUER TECLA PARA CONTINUAR]"
    read enter
else
    echo "A chave ssh já existe"
    echo "Ignorando essa etapa"
fi

#INSTALACAO JETBRAINS TOOLBOX
echo "Installing Jetbrains Toolbox"
sleep 2s
cd ~/Downloads
wget -O ~/Downloads/toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
mkdir ~/Downloads/Toolbox
tar xvzf toolbox.tar.gz -C ~/Downloads/Toolbox
sudo rm -r ~/Downloads/toolbox.tar.gz
cd ~/Downloads/Toolbox/jetbrains-toolbox-1.15.5796/
./jetbrains-toolbox

#INSTALAÇÃO CHROME
echo "Installing Chrome"
sleep 2s
cd ~/Downloads/
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo rm -r ~/Downloads/chrome.deb

# #ISNTALAÇÃO N98 MAGERUN2
echo "Installing n98 magerun2"
sleep 2s
curl -O https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar
sudo mv ./n98-magerun2.phar /usr/local/bin/

#GERACAO CHAVES SSL
echo "creating ssl keys"
sleep 2s
cd /home/$USER
mkdir .ssl
cd .ssl
openssl req -newkey rsa:2048 -nodes -keyout domain.key -x509 -days 365 -out domain.crt

#INSTALL MAGENTO CLOUD CLI
echo "Installing Magento cloud cli"
sleep 2s
curl -sS https://accounts.magento.cloud/cli/installer | php
source $HOME/.bashrc
echo "Installation finish"
