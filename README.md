# PeerTube-Docker (unmaintained)

[![Build Status](https://travis-ci.org/Chocobozzz/PeerTube-Docker.svg?branch=master)](https://travis-ci.org/Chocobozzz/PeerTube-Docker)

Dockerfile for [PeerTube](https://github.com/Chocobozzz/PeerTube).

FOR TESTING PURPOSE, DO NOT USE IN PRODUCTION !

## Get the image

### From Docker Hub

    $ docker pull chocobozzz/peertube

### Build yourself

    $ git clone https://github.com/Chocobozzz/PeerTube-Docker
    $ cd PeerTube-Docker
    $ docker build -t yourname/peertube .

## Run the image

    $ docker run --publish=80:80 yourname/peertube

Once the server is listening, you can test it at `http://localhost:80`. You can see the administrator password in the container logs.
