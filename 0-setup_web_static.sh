#!/usr/bin/env bash
# Install Nginx if its not already installed.
# Creates necessery directories if it does not exist
# Creates an html file and creates a symbolic link to test the folder.
# Give ownership to the data folder to ubuntu user and group.
# Update Nginx configuration and restarts it.


echo -e "\e[1;32m START\e[0m"

# Updating the packages
sudo apt-get -y update
sudo apt-get -y install nginx
echo -e "\e[1;32m Packages updated\e[0m"
echo

# Configuring the firewall
sudo ufw allow 'Nginx HTTP'
echo -e "\e[1;32m Allow incomming NGINX HTTP connections\e[0m"
echo

# Createin the directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo -e "\e[1;32m directories created"
echo

# Adding a test string
echo "<h1>Welcome to www.tagalfinance.tech</h1>" > /data/web_static/releases/test/index.html
echo -e "\e[1;32m Test string added\e[0m"
echo

# Preventing overwrite
if [ -d "/data/web_static/current" ];
then
    echo "path /data/web_static/current exists"
    sudo rm -rf /data/web_static/current;
fi;
echo -e "\e[1;32m prevent overwrite\e[0m"
echo

# Creates a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data

sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

sudo ln -sf '/etc/nginx/sites-available/default' '/etc/nginx/sites-enabled/default'
echo -e "\e[1;32m Symbolic link created\e[0m"
echo

# Restarts NGINX
sudo service nginx restart
echo -e "\e[1;32m restart NGINX\e[0m"
