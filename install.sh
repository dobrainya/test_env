#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo true

sudo apt update
sudo apt -y install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# install docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# remove old hosts if exists
sudo sed -i '/#test-app-host$/d' /etc/hosts

# write new hosts into hosts file
sudo bash -c "cat >> /etc/hosts ${SCRIPT_DIR}/etc/hosts.txt"

# setting up the docker
sudo usermod -aG docker $USER

# build images and create containers
cd "${SCRIPT_DIR}" && sudo -u $USER docker compose -f docker-compose.yml up --no-start

#delete app folder before clone
rm -rf ./app

#clone application
git clone https://github.com/dobrainya/test.git app

# install composer
sudo -u $USER docker compose run --rm backend composer install

# run migrations
sudo -u $USER docker compose run --service-ports --rm backend bash -c "echo y | ./yii migrate/up"

# clean up
sudo apt autoremove -y
sudo apt clean

echo 'Done! You need to restart your system'
