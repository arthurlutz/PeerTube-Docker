FROM debian:jessie
MAINTAINER Florian Bigard <florian.bigard@gmail.com>

RUN echo "deb http://ftp.debian.org/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install ffmpeg postgresql-9.4 openssl sudo curl git build-essential nginx
RUN apt-get clean

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
RUN apt-get -y install -y nodejs
RUN npm install -g npm@3

# Create peertube user
RUN useradd -m -d /home/peertube_user -s /bin/bash -p peertube_user peertube_user

# Database setup
USER postgres
RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER peertube WITH PASSWORD 'peertube_docker';" \
    && createdb -O peertube peertube_prod

# PeerTube setup
USER peertube_user
WORKDIR /home/peertube_user

RUN git clone https://github.com/Chocobozzz/PeerTube
WORKDIR PeerTube
RUN npm install
RUN npm run build

ADD production.yaml /home/peertube_user/PeerTube/config

USER root

# Copy scripts
ADD peertube_start.sh /home/peertube_user/peertube_start.sh

RUN rm /etc/nginx/sites-enabled/default
ADD peertube_nginx.conf /etc/nginx/sites-enabled/peertube

RUN chown peertube_user /home/peertube_user/peertube_start.sh
RUN chmod +x /home/peertube_user/peertube_start.sh

EXPOSE 80

ENTRYPOINT ["/home/peertube_user/peertube_start.sh"]
