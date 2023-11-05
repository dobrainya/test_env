#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#sudo add-apt-repository -y \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   # $(lsb_release -cs) \
   # stable"

#sudo apt update
#sudo apt install -y --no-install-recommends docker-ce

#sudo curl -fsSL "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

# удаляем старую запись из Hosts
sudo sed -i '/#test-app-host$/d' /etc/hosts

# записываем новые хосты
sudo bash -c "cat >> /etc/hosts ${SCRIPT_DIR}/install/etc/hosts.txt"


# Настройка docker
#sudo usermod -aG docker $USER

cd "${SCRIPT_DIR}" && docker compose -f docker-compose.yml up --no-start

git clone git@github.com:dobrainya/test.git app

# install composer
docker-compose run --rm backend composer install

# run migrations
docker compose run --rm backend bash -c "echo y | ./yii migrate/up"

sudo apt autoremove -y
sudo apt clean
