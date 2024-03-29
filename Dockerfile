ARG BASE_IMAGE=node:14
FROM ${BASE_IMAGE}
LABEL maintainer "kokororin <i@kotori.love>"

ARG TAGS=14

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    gnupg \
    curl \
    unzip

RUN if [ -z "${TAGS##*python*}" ]; then \
        apt-get install -y python python3 build-essential; \
    fi

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list" && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget -q http://ftp.cn.debian.org/debian/pool/main/f/fonts-noto-cjk/fonts-noto-cjk_20201206-cjk+repack1-1_all.deb -O fonts-noto-cjk.deb && \
    dpkg -i fonts-noto-cjk.deb && \
    wget -q https://github.com/adobe-fonts/source-sans/releases/download/3.028R/source-sans-3v028R.zip -O source-sans.zip && \
    unzip source-sans.zip -d source-sans && cd source-sans && mv ./OTF /usr/share/fonts/ && \
    fc-cache -f -v && \
    rm -f /tmp/fonts-noto-cjk.deb && \
    rm -rf /tmp/source-sans*
    
RUN npm install -g pnpm@latest

ENV CHROME_BIN /usr/bin/google-chrome-stable
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
