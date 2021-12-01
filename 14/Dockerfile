FROM node:14-buster as builder
LABEL maintainer "kokororin <i@kotori.love>"

ARG REFRESHED_AT
ENV REFRESHED_AT $REFRESHED_AT

RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    curl \
    unzip && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get remove unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget -q http://ftp.cn.debian.org/debian/pool/main/f/fonts-noto-cjk/fonts-noto-cjk_20201206-cjk+repack1-1_all.deb -O fonts-noto-cjk.deb && \
    dpkg -i fonts-noto-cjk.deb && \
    wget -q https://github.com/adobe-fonts/source-sans/releases/download/3.028R/source-sans-3v028R.zip -O source-sans.zip && \
    unzip source-sans.zip -d source-sans && cd source-sans && mv ./OTF /usr/share/fonts/ && \
    fc-cache -f -v && \
    rm -f /tmp/fonts-noto-cjk.deb && \
    rm -rf /tmp/source-sans*

ENV CHROME_BIN /usr/bin/google-chrome-stable
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
