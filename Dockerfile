FROM ubuntu:20.04

# https://docs.docker.com/install/linux/docker-ce/debian/

# Install the latest Docker CE binaries
USER root
RUN apt-get update && \
    apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      default-jre \
      make \
      software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce
