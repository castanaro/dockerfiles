# syntax=docker/dockerfile:1
FROM ubuntu:latest

WORKDIR /opt/
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y mlocate unzip curl golang git wget build-essential checkinstall libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
RUN wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz
RUN tar zxvf Python-3.9.16.tgz
RUN cd Python-3.9.16 && ./configure && make && make install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN python3 -m pip install prowler-cloud
RUN python3 -m pip install scoutsuite
RUN python3 -m pip install pacu
RUN git clone https://github.com/BishopFox/cloudfox.git
RUN cd cloudfox/ && go build .

ENV PATH="$PATH:/opt/:/opt/cloudfox/"
