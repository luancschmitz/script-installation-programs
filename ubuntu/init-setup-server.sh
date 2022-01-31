#!/bin/bash

# Instalowanie podstawowych narzędzi do funkcjonowania serwera

apt update
apt upgrade -y
apt install net-tools htop ssh
