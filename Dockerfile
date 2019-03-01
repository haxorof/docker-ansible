FROM alpine

RUN apk update && \
    apk add --no-cache ansible && \
    wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-18.09.3.tgz | tar -xz -C /usr/lib && \
    ln -s /usr/lib/docker/docker /usr/bin/docker && \
    rm -rf /var/cache/apk/*

VOLUME ["/mnt"]

WORKDIR /mnt

CMD [ "/usr/bin/ansible-playbook", "playbook.yml" ]
