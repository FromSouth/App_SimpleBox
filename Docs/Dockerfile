# Use an official lightweight Ubuntu base image
FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get update && apt-get install -y sudo openssh-server mysql-server mysql-client phpmyadmin

# Configure MySQL for development purposes (WARNING: insecure)
RUN service mysql start && \
    mysql -e "CREATE DATABASE vulnerable_db;" && \
    mysql -e "CREATE USER 'user'@'%' IDENTIFIED BY 'password';" && \
    mysql -e "GRANT ALL ON vulnerable_db.* TO 'user'@'%';" && \
    mysql -e "SET GLOBAL sql_mode = '';"

# Configure PHPMyAdmin
# Note: As of my last update, PHPMyAdmin 4.8.1 might not be directly available via apt and might have security vulnerabilities.
RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/mysql/admin-pass password password" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/mysql/app-pass password password" | debconf-set-selections && \
    echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections && \
    dpkg-reconfigure -f noninteractive phpmyadmin

# Add user 'gm' and add to root group
RUN useradd -m gm -s /bin/bash && echo "gm:gm" | chpasswd && usermod -aG sudo gm

# Add user 'allen', set up user environment
RUN useradd -m allen -s /bin/bash && echo "allen:password" | chpasswd && \
    echo "user's flag" > /home/allen/user.txt && chown allen:allen /home/allen/user.txt

# Enable SSH service
RUN service ssh start

# Set up file for privilege escalation
RUN echo "root's flag" > /root/root.txt && \
    echo "ALL ALL=(ALL) NOPASSWD: /bin/cp" >> /etc/sudoers
