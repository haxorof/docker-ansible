FROM alpine:3.9.4

LABEL org.opencontainers.image.title="haxorof/ansible" \
      org.opencontainers.image.description="Ansible + Docker CLI" \
      org.opencontainers.image.source="https://github.com/haxorof/docker-ansible" \
      org.opencontainers.image.licenses="MIT"    

COPY run_tests.sh /mnt/run_tests.sh

RUN apk update \
    && apk add --no-cache ansible \
    && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-18.09.5.tgz | tar -xz -C /usr/lib \
    && ln -s /usr/lib/docker/docker /usr/bin/docker \
    && mkdir -p /etc/ansible/roles \
    && echo 'localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3' > /etc/ansible/hosts \
    && chmod +x /mnt/run_tests.sh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache

WORKDIR /mnt

CMD [ "/usr/bin/ansible-playbook", "playbook.yml" ]
