FROM debian:latest

RUN apt update
RUN apt install -y wget zip build-essential libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev perl tcl tk python3 libpcre2-dev

RUN wget "https://github.com/git/git/archive/refs/tags/v2.49.0.zip"
RUN unzip "v2.49.0.zip"
WORKDIR /git-2.49.0
RUN make 
RUN make install
RUN git --version