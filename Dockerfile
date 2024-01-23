FROM cm2network/steamcmd:root
LABEL maintainer="motyl.kubo@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
    xdg-user-dirs=0.17-2 \
    procps=2:3.3.17-5 \
    wget=1.21-1+deb11u1 \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/itzg/rcon-cli/releases/download/1.6.4/rcon-cli_1.6.4_linux_amd64.tar.gz -O - | tar -xz
RUN mv rcon-cli /usr/bin/rcon-cli

ENV PORT= \
    PUID=1000 \
    PGID=1000 \
    PLAYERS= \
    MULTITHREADING=false \
    COMMUNITY=false \
    PUBLIC_IP= \
    PUBLIC_PORT= \
    SERVER_PASSWORD= \
    SERVER_NAME= \
    ADMIN_PASSWORD= \
    UPDATE_ON_BOOT=true \
    RCON_ENABLED=true \
    RCON_PORT=25575 \
    QUERY_PORT=27015 \
    AWS_S3_BUCKET= \
    AWS_S3_BACKUP_EVERY_SECONDS=600 \
    AWS_ACCESS_KEY_ID= \
    AWS_SECRET_ACCESS_KEY=

# Install and configure AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN bash ./aws/install

COPY ./scripts/* /home/steam/server/
RUN chmod +x /home/steam/server/*.sh

WORKDIR /home/steam/server

HEALTHCHECK --start-period=5m \
    CMD pgrep "PalServer-Linux" > /dev/null || exit 1

EXPOSE ${PORT} ${RCON_PORT}
ENTRYPOINT ["/home/steam/server/init.sh"]
