# zzddns

A configuration-based command to keep your DDNS up-to-date with the system dynamic IP address

## How to

````shell
wget https://raw.githubusercontent.com/TurboLabIt/zzddns/master/setup.sh?$(date +%s) -O - | sudo bash && sudo cp /usr/local/turbolab.it/zzddns/zzddns.default.conf /etc/turbolab.it/zzddns.conf && nano /etc/turbolab.it/zzddns.conf && zzddns

````
