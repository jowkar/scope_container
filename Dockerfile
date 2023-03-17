FROM ubuntu:18.04

MAINTAINER jowkar joakim.karlsson@perkins.org.au

WORKDIR /app

RUN apt-get update \
    && apt install -y python3-pip \
    && apt install -y python3.7 \
    && apt install -y python3.7-dev \
    && python3.7 -m pip install "pip==21.0.1" \
    && pip3 install --upgrade pip \
    && rm -rf /var/lib/apt/lists/*

RUN python3.7 -m pip install Cython "tensorflow==1.15.2" "pandas<=0.24.2" "numpy<=1.17.2" mkl-service "keras==2.3.1" https://github.com/Theano/Theano/archive/master.zip https://github.com/Lasagne/Lasagne/archive/master.zip cancerscope

RUN python3.7 -c 'import cancerscope'

CMD ["/usr/bin/python3.7"]
