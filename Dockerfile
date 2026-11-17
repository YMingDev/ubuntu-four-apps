FROM kasmweb/core-ubuntu-noble:1.19.0
USER root
ENV DEBIAN_FRONTEND=noninteractive
COPY packages/ /tmp/four-apps/
RUN apt-get update && apt-get install -y --no-install-recommends \
      /tmp/four-apps/chrome.deb /tmp/four-apps/adspower.deb /tmp/four-apps/hiddify.deb \
      libgtk-3-0 libasound2t64 libsecret-1-0 libayatana-appindicator3-1 \
      fonts-noto-cjk xz-utils \
    && mkdir -p /opt/telegram \
    && tar -xJf /tmp/four-apps/telegram.tar.xz -C /opt/telegram --strip-components=1 \
    && ln -s /opt/telegram/Telegram /usr/local/bin/telegram \
    && rm -rf /tmp/four-apps /var/lib/apt/lists/*
COPY configure.sh /tmp/configure-four-apps.sh
RUN bash /tmp/configure-four-apps.sh && rm /tmp/configure-four-apps.sh \
    && /dockerstartup/set_user_permission.sh /home/kasm-default-profile
ENV HOME=/home/kasm-user
WORKDIR /home/kasm-user
USER 1000
