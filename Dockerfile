FROM alpine

COPY run_tests.sh /mnt/run_tests.sh

RUN apk update \
    && apk add --no-cache ansible \
    && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-18.09.3.tgz | tar -xz -C /usr/lib \
    && ln -s /usr/lib/docker/docker /usr/bin/docker \
    && chmod +x /mnt/run_tests.sh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache

VOLUME ["/mnt"]

WORKDIR /mnt

CMD [ "/usr/bin/ansible-playbook", "playbook.yml" ]
