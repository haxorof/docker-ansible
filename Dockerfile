FROM alpine

LABEL org.opencontainers.image.source="https://github.com/haxorof/docker-ansible/tree/$SOURCE_BRANCH" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.revision="$SOURCE_COMMIT" \
      org.opencontainers.image.title="$DOCKER_REPO" \
      org.opencontainers.image.description="Ansible + Docker CLI"

COPY run_tests.sh /mnt/run_tests.sh

RUN apk update \
    && apk add --no-cache ansible \
    && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-18.09.3.tgz | tar -xz -C /usr/lib \
    && ln -s /usr/lib/docker/docker /usr/bin/docker \
    && mkdir -p /etc/ansible/roles \
    && echo 'localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3' > /etc/ansible/hosts \
    && chmod +x /mnt/run_tests.sh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && env

WORKDIR /mnt

CMD [ "/usr/bin/ansible-playbook", "playbook.yml" ]
