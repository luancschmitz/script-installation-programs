#!/bin/bash
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install -y nginx docker.io mysql-server wget
sudo apt install -y php7.2 php7.2-fpm php7.1 php7.1-fpm php7.0 php7.0-fpm php5.6 php5.6-fpm
sudo apt install -y php7.2-curl php7.2-gd php7.2-json php7.2-mbstring
sudo apt install -y php7.1-curl php7.1-gd php7.1-json php7.1-mbstring php7.1-mcrypt
sudo apt install -y php7.0-curl php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt
sudo usermod -aG docker $USER
echo É NECESSÁRIO REINICIAR A MÁUINA PARA TERMINAR A INSTALAÇÃO DO DOCKER
sleep 1s
echo -----Geração da Chave SSH -----
ssh-keygen -t rsa -b 4096 -C "test@example.com" -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
echo COPIE O CONTEÚDO E JOGE NAS CONFIGURAÇÕES DE CHAVES SSH DO BITBUCKET [PRESSIONE ENTER PARA CONTINUAR]
read enter
mkdir ~/Downloads
cd ~/Downloads
wget -O ~/Downloads/toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5796.tar.gz
mkdir ~/Downloads/Toolbox
tar xvzf toolbox.tar.gz -C ~/Downloads/Toolbox
echo Para executar o Toolbox e baixar o PhpStorm basta acessar a pasta /Downloads/Toolbox/jetbrains-toolbox-1.15.5796 e rodar o arquivo que está dentro da mesma.
sleep 5
cd ~/Downloads/Toolbox/jetbrains-toolbox-1.15.5796/
./jetbrains-toolbox
sudo apt install -y silversearcher-ag
done
