FROM python:3.8.0-alpine

LABEL org.opencontainers.image.title="haxorof/ansible" \
    org.opencontainers.image.description="Ansible + additions" \
    org.opencontainers.image.source="https://github.com/haxorof/docker-ansible" \
    org.opencontainers.image.licenses="MIT"    

ENV DOCKER_VERSION 19.03.1

COPY requirements.txt .

RUN apk update \
    && apk add --no-cache linux-headers \
    build-base \
    libffi-dev \
    openssl-dev \
    openssh \
    sshpass \
    git \
    && python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt \
    && wget -O - https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xz -C /usr/lib \
    && ln -s /usr/lib/docker/docker /usr/bin/docker \
    && mkdir -p /etc/ansible/roles \
    && echo 'localhost ansible_connection=local ansible_python_interpreter=/usr/local/bin/python3' > /etc/ansible/hosts \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && adduser -u 1000 -D ansible-1000 \
    && adduser -u 1001 -D ansible-1001    

WORKDIR /mnt

CMD [ "ansible-playbook", "playbook.yml" ]
