sudo apt update && sudo apt upgrade -y
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.25.0/blackbox_exporter-0.25.0.linux-amd64.tar.gz
tar -xvf blackbox_exporter-0.25.0.linux-amd64.tar.gz
cd blackbox_exporter-0.25.0.linux-amd64/
sudo mv blackbox_exporter /usr/local/bin/
sudo mkdir /etc/blackbox_exporter
sudo vi /etc/blackbox_exporter/blackbox.yml
   #######

   modules:
  http_2xx:
    prober: http
    timeout: 5s
    http:
      valid_http_versions: [ "HTTP/1.1", "HTTP/2" ]
      valid_status_codes: []  # Defaults to 2xx
      fail_if_ssl: false
      fail_if_not_ssl: false

##########

sudo useradd -rs /bin/false blackbox
sudo chown -R blackbox:blackbox /etc/blackbox_exporter


Step 2: Create a Systemd Service File for Blackbox Exporter

sudo vi /etc/systemd/system/blackbox_exporter.service

#####################

  [Unit]
Description=Blackbox Exporter
Documentation=https://github.com/prometheus/blackbox_exporter
After=network.target

[Service]
User=blackbox
Group=blackbox
Type=simple
ExecStart=/usr/local/bin/blackbox_exporter --config.file=/etc/blackbox_exporter/blackbox.yml
Restart=always

[Install]
WantedBy=multi-user.target


################


Step 3: Enable and Start Blackbox Exporter


sudo systemctl daemon-reload
sudo systemctl start blackbox_exporter
sudo systemctl enable blackbox_exporter


sudo systemctl status blackbox_exporter


http://<your-server-ip>:9115
