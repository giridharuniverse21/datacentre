sudo apt update -y
sudo apt install default-jdk -y
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.60/bin/apache-tomcat-9.0.60.tar.gz
tar -zxvf apache-tomcat-9.0.60.tar.gz -C /opt
sudo mv /opt/apache-tomcat-9.0.60.tar.gz /opt/tomcat

sudo touch /etc/systemd/system/tomcat.service
cd /etc/systemd/system/

echo [Unit] > tomcat.service
echo "Description=Tomcat 9.0 servlet container" >> tomcat.service
echo "After=network.target" >> tomcat.service
echo "[Service]" >> tomcat.service
echo "Type=forking" >> tomcat.service
echo "User=tomcat" >> tomcat.service
echo "Group=tomcat" >> tomcat.service
echo "Environment="JAVA_HOME=/usr/lib/jvm/default-java" >> tomcat.service
echo "Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom" >> tomcat.service
echo "Environment="CATALINA_BASE=/opt/tomcat/latest" >> tomcat.service
echo "Environment="CATALINA_HOME=/opt/tomcat/latest" >> tomcat.service
echo "Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid" >> tomcat.service
echo "Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC" >> tomcat.service
echo "ExecStart=/opt/tomcat/latest/bin/startup.sh" >> tomcat.service
echo "ExecStop=/opt/tomcat/latest/bin/shutdown.sh" >> tomcat.service
echo "[Install]" >> tomcat.service
echo "WantedBy=multi-user.target" >> tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl stop tomcat
sudo systemctl restart tomcat
sudo systemctl enable tomcat
