#!/bin/bash

apt-get update && apt-get install -y unzip wget

# Versions
ENVOY_VERSION="1.16.4"
ENVOY_DOWNLOAD="https://getenvoy.io/cli"

CONSUL_VERSION="1.9.6"
CONSUL_DOWNLOAD="https://releases.hashicorp.com/consul/$${CONSUL_VERSION}/consul_$${CONSUL_VERSION}_linux_amd64.zip"

# Get internal IP
LOCAL_IPV4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

cd /tmp

# Fetch Consul
curl -sSL --fail -o /tmp/consul.zip $${CONSUL_DOWNLOAD}
unzip -d /tmp /tmp/consul.zip
mv /tmp/consul /usr/bin/consul
chmod +x /usr/bin/consul

# Fetch Envoy
curl -sSL --fail $${ENVOY_DOWNLOAD} | sudo bash -s -- -b /usr/local/bin
getenvoy use $${ENVOY_VERSION}
getenvoy run --version
cp ~/.getenvoy/versions/$${ENVOY_VERSION}/bin/envoy /usr/bin/

# Create the consul config
mkdir -p /etc/consul
mkdir -p /etc/consul/certs

%{ if consul_ca_file != "" }
echo '${consul_ca_file}' | base64 -d > /etc/consul/ca.pem
%{ endif }

%{ if consul_config_file != "" }
echo '${consul_config_file}' | base64 -d > /etc/consul/config.json
%{ endif }

# Setup systemd
cat << EOF > /etc/systemd/system/consul.service
[Unit]
Description=Consul Server
After=syslog.target network.target
[Service]
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul
ExecStop=/bin/sleep 5
Restart=always
[Install]
WantedBy=multi-user.target
EOF

chmod 644 /etc/systemd/system/consul.service

systemctl daemon-reload
systemctl enable consul
systemctl start consul