mkdir $(pwd)/etc-pihole
mkdir $(pwd)/etc-dnsmasq.d

export WEBPASSWORD="maybeputapasswordhere"

docker run -d \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 80:80 \
    -p 443:443 \
    -e TZ="Europe/Oslo" \
    -v "$(pwd)/etc-pihole/:/etc/pihole/" \
    -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --restart=unless-stopped \
    --hostname pi.hole \
    -e VIRTUAL_HOST="pi.hole" \
    -e PROXY_LOCATION="pi.hole" \
    -e ServerIP="127.0.0.1" \
    pihole/pihole:latest

sudo apt -y install openjdk-8-jdk-headless

git clone -b wakeonlan https://github.com/TinyAngryKitten/PIMicroservices.git
cd PIMicroservices
./gradlew run &
