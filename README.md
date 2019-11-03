# Ansible + additions

[![Docker Pulls](https://img.shields.io/docker/pulls/haxorof/ansible.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)
[![Docker Image Size](https://img.shields.io/microbadger/image-size/haxorof/ansible/latest.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)
[![License](https://img.shields.io/github/license/haxorof/docker-ansible.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)

Ansible with additions.

## Additions

Users/Groups:

- ansible-1000
  - uid=1000
  - gid=1000
- ansible-1001
  - uid=1001
  - gid=1001

Python libraries:

- jmespath
- pyvmomi (for VMWare modules)

Packages/Tools:

- docker-cli
- git
- openssh

## How to use this container

Below assume a `playbook.yml` file is located in current directory:

```console
# docker run --rm -v ${PWD}:/mnt haxorof/ansible
```

To override the default command set you can just add your own arguments after the images name:

```console
# docker run --rm -v ${PWD}:/mnt haxorof/ansible ansible -m setup -c local localhost
```

## How to use Docker CLI with Ansible to target Python container

Start a Python container in a terminal:

```console
# docker run -it --rm --name=target python sh
```

In a second terminal run the following which will do an Ansible ping to that Python container:

```console
# docker run --rm -v /var/run/docker.sock:/var/run/docker.sock haxorof/ansible sh -c "echo 'target ansible_connection=docker' > hosts && ansible -m ping -i hosts all"
```

