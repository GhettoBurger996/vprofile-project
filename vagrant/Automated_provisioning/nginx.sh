# adding repository and installing nginx		
sudo apt update && sudo apt upgrade -y
sudo apt install nginx -y

sudo bash -c 'cat <<EOT > /etc/nginx/sites-available/vproapp
upstream vproapp {

 server app01:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT'

sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

# start nginx service and firewall
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx
