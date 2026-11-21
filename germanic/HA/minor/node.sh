sudo dpkg --remove nodejs
sudo apt-get purge nodejs npm
sudo dpkg --configure -a
sudo apt-get --fix-broken purge
# wks
ps -eo pid,stat,etime,%cpu,cmd | grep -E '[d]pkg|[a]pt'
df -h / /var
sudo tail -n 20 /var/log/dpkg.log

apt-cache rdepends --installed nodejs
sudo apt-get -s purge npm
sudo apt install npm

sudo apt 