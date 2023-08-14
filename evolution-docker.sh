#######################################################

clear
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _                             _              _               32m\e[0m"
echo -e "\e[32m| |                _          | |            | |              32m\e[0m"
echo -e "\e[32m| | ____    ___  _| |_  _____ | |  _____   __| |  ___    ____ 32m\e[0m"
echo -e "\e[32m| ||  _ \  /___)(_   _)(____ || | (____ | / _  | / _ \  / ___)32m\e[0m"
echo -e "\e[32m| || | | ||___ |  | |_ / ___ || | / ___ |( (_| || |_| || |    32m\e[0m"
echo -e "\e[32m|_||_| |_|(___/    \__)\_____| \_)\_____| \____| \___/ |_|    32m\e[0m"
echo -e "\e[32m                                                              32m\e[0m"
echo -e "\e[32m _______                _                 _                  _______  ______   _ 32m\e[0m"
echo -e "\e[32m(_______)              | |           _   (_)                (_______)(_____ \ | |32m\e[0m"
echo -e "\e[32m _____    _   _   ___  | |  _   _  _| |_  _   ___   ____     _______  _____) )| |32m\e[0m"
echo -e "\e[32m|  ___)  | | | | / _ \ | | | | | |(_   _)| | / _ \ |  _ \   |  ___  ||  ____/ | |32m\e[0m"
echo -e "\e[32m| |_____  \ V / | |_| || | | |_| |  | |_ | || |_| || | | |  | |   | || |      | |32m\e[0m"
echo -e "\e[32m|_______)  \_/   \___/  \_)|____/    \__)|_| \___/ |_| |_|  |_|   |_||_|      |_|32m\e[0m"
echo -e "\e[32m                                                                                 32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

sleep 3

#######################################################

echo "Preencha as informações a serguir para criar o env"
echo ""
read -p "Digite seu dominio para acessar a api (ex: api.dominio.com): " dominio
echo ""
read -p "Digite a porta da api (padrão: 8080): " porta # a ver
echo ""
read -p "Digite o nome da sua empresa (ex: OrionDesign): " client
echo ""
echo "crie sua ApiKey no link: https://codebeautify.org/generate-random-hexadecimal-numbers"
read -p "Digite sua ApiKey Global (ex: 1169f6f7306fe524e54f79e45ba012cf): " key
echo ""
read -p "Digite seu email (ex: contato@dominio.com | sera usado no proxy reverso): " mail
echo ""

#######################################################

echo "Instalando as Dependencias"

sleep 3

clear

sudo apt update -y

sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - && apt-get install -y nodejs

npm install -g npm@latest

npm install -g pm2@latest && apt-get install -y git zip unzip nload snapd curl wget sudo

sudo timedatectl set-timezone America/Sao_Paulo

apt update && apt -y upgrade

apt-get install -y nginx

systemctl start nginx

systemctl enable nginx

snap install --classic certbot

rm /etc/nginx/sites-enabled/default

clear

#######################################################

git clone https://github.com/EvolutionAPI/evolution-api.git

cd evolution-api

git branch -a

git checkout develop

cd

echo "Instalando as Dependencias"

cat > env.yml << EOL

SERVER_URL=http://$dominio

# Cors - * for all or set separate by commas -  ex.: 'yourdomain1.com, yourdomain2.com'
CORS_ORIGIN=*
CORS_METHODS=POST,GET,PUT,DELETE
CORS_CREDENTIALS=true

# Determine the logs to be displayed
LOG_LEVEL=ERROR,WARN,DEBUG,INFO,LOG,VERBOSE,DARK,WEBHOOKS
LOG_COLOR=true
# Log Baileys - "fatal" | "error" | "warn" | "info" | "debug" | "trace"
LOG_BAILEYS=error

# Determine how long the instance should be deleted from memory in case of no connection.
# Default time: 5 minutes
# If you don't even want an expiration, enter the value false
DEL_INSTANCE=false

# Temporary data storage
STORE_MESSAGES=true
STORE_MESSAGE_UP=true
STORE_CONTACTS=true
STORE_CHATS=true

# Set Store Interval in Seconds (7200 = 2h)
CLEAN_STORE_CLEANING_INTERVAL=7200
CLEAN_STORE_MESSAGES=true
CLEAN_STORE_MESSAGE_UP=true
CLEAN_STORE_CONTACTS=true
CLEAN_STORE_CHATS=true

# Permanent data storage
DATABASE_ENABLED=true
DATABASE_CONNECTION_URI=mongodb://root:root@mongodb:27017/?authSource=admin&readPreference=primary&ssl=false&directConnection=true
DATABASE_CONNECTION_DB_PREFIX_NAME=evdocker

# Choose the data you want to save in the application's database or store
DATABASE_SAVE_DATA_INSTANCE=false
DATABASE_SAVE_DATA_NEW_MESSAGE=false
DATABASE_SAVE_MESSAGE_UPDATE=false
DATABASE_SAVE_DATA_CONTACTS=false
DATABASE_SAVE_DATA_CHATS=false

REDIS_ENABLED=true
REDIS_URI=redis://redis:6379
REDIS_PREFIX_KEY=evdocker

# Global Webhook Settings
# Each instance's Webhook URL and events will be requested at the time it is created
## Define a global webhook that will listen for enabled events from all instances
WEBHOOK_GLOBAL_URL=''
WEBHOOK_GLOBAL_ENABLED=false
# With this option activated, you work with a url per webhook event, respecting the global url and the name of each event
WEBHOOK_GLOBAL_WEBHOOK_BY_EVENTS=false
## Set the events you want to hear  
WEBHOOK_EVENTS_APPLICATION_STARTUP=false
WEBHOOK_EVENTS_QRCODE_UPDATED=true
WEBHOOK_EVENTS_MESSAGES_SET=true
WEBHOOK_EVENTS_MESSAGES_UPSERT=true
WEBHOOK_EVENTS_MESSAGES_UPDATE=true
WEBHOOK_EVENTS_MESSAGES_DELETE=true
WEBHOOK_EVENTS_SEND_MESSAGE=true
WEBHOOK_EVENTS_CONTACTS_SET=true
WEBHOOK_EVENTS_CONTACTS_UPSERT=true
WEBHOOK_EVENTS_CONTACTS_UPDATE=true
WEBHOOK_EVENTS_PRESENCE_UPDATE=true
WEBHOOK_EVENTS_CHATS_SET=true
WEBHOOK_EVENTS_CHATS_UPSERT=true
WEBHOOK_EVENTS_CHATS_UPDATE=true
WEBHOOK_EVENTS_CHATS_DELETE=true
WEBHOOK_EVENTS_GROUPS_UPSERT=true
WEBHOOK_EVENTS_GROUPS_UPDATE=true
WEBHOOK_EVENTS_GROUP_PARTICIPANTS_UPDATE=true
WEBHOOK_EVENTS_CONNECTION_UPDATE=true
WEBHOOK_EVENTS_CALL=true
# This event fires every time a new token is requested via the refresh route
WEBHOOK_EVENTS_NEW_JWT_TOKEN=false

# Name that will be displayed on smartphone connection
CONFIG_SESSION_PHONE_CLIENT=$client
# Browser Name = chrome | firefox | edge | opera | safari
CONFIG_SESSION_PHONE_NAME=chrome

# Set qrcode display limit
QRCODE_LIMIT=30

# Defines an authentication type for the api
# We recommend using the apikey because it will allow you to use a custom token,
# if you use jwt, a random token will be generated and may be expired and you will have to generate a new token
# jwt or 'apikey'
AUTHENTICATION_TYPE=apikey
## Define a global apikey to access all instances.
### OBS: This key must be inserted in the request header to create an instance.
AUTHENTICATION_API_KEY=$key
AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=true
## Set the secret key to encrypt and decrypt your token and its expiration time
# seconds - 3600s ===1h | zero (0) - never expires
AUTHENTICATION_JWT_EXPIRIN_IN=0
AUTHENTICATION_JWT_SECRET='noironoironoiro'
EOL

#######################################################

sudo mv env.yml evolution-api/src/env.yml

cd

cd evolution-api

chmod +x docker.sh

./docker.sh

#######################################################

clear

cd

echo "Proxy Reverso"

cat > api << EOL
server {
  server_name $dominio;

  location / {
    proxy_pass http://127.0.0.1:$porta;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_cache_bypass \$http_upgrade;
  }
}
EOL

#######################################################

cd

sudo mv api /etc/nginx/sites-available/api

ln -s /etc/nginx/sites-available/api /etc/nginx/sites-enabled

systemctl reload nginx

sudo certbot --nginx --email $mail --redirect --agree-tos -d $dominio

#######################################################

echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _                             _              _        \e[0m"
echo -e "\e[32m| |                _          | |            | |       \e[0m"
echo -e "\e[32m| | ____    ___  _| |_  _____ | |  _____   __| |  ___  \e[0m"
echo -e "\e[32m| ||  _ \  /___)(_   _)(____ || | (____ | / _  | / _ \ \e[0m"
echo -e "\e[32m| || | | ||___ |  | |_ / ___ || | / ___ |( (_| || |_| |\e[0m"
echo -e "\e[32m|_||_| |_|(___/    \__)\_____| \_)\_____| \____| \___/ \e[0m"
echo -e "\e[32m                                                       \e[0m"              
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mAcesse a Evolution API através do link: https://$dominio\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mInscreva-se no meu Canal: https://youtube.com/oriondesign_oficial\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mSugestões ou duvidas: https://wa.me/+5511973052593\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"