# Ansible + additions

[![Docker Pulls](https://img.shields.io/docker/pulls/haxorof/ansible.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)
[![Docker Image Size](https://img.shields.io/microbadger/image-size/haxorof/ansible/latest.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)
[![License](https://img.shields.io/github/license/haxorof/docker-ansible.svg?style=popout-square)](https://hub.docker.com/r/haxorof/ansible/)
[![CI](https://github.com/haxorof/docker-ansible/workflows/CI/badge.svg)](https://github.com/haxorof/docker-ansible/actions?query=workflow%3ACI)

Ansible with additions.

## Simple Tags

- `v2.9-alpine`
- `v2.9-centos7`
- `v2.9-centos8`
- `v2.8-alpine`
- `v2.8-centos7`
- `v2.8-centos8`

## Shared Tags

- `v2.9`, `latest-alpine`, `latest`
  - `v2.9-alpine`
- `latest-centos7`
  - `v2.9-centos7`
- `latest-centos8`
  - `v2.9-centos8`
- `v2.8`
  - `v2.8-alpine`

## Additions

### Users/Groups

Container will run as user `ansible-10000` by default. However, when you build your own image based on this `root` will be set and you need to set it back yourself to `ansible-10000` if you want.

- `ansible-1000`
  - uid=1000
  - gid=1000
- `ansible-1001`
  - uid=1001
  - gid=1001
- `ansible-10000`
  - uid=10000
  - gid=10000

**Note!** All ansible users will have sudo rights. This is for convenience since some roles etc are not that well implemented.

### Python libraries

- jmespath
- pyvmomi (for VMWare modules)
- netaddr

### Packages/Tools

- docker-cli
- git
- openssh
- sudo

### Backported fixes

**Important!** From Ansible 2.10 plugins will have its own lifecycle and not included in `ansible/ansible` repository.

- [netbox.py](https://raw.githubusercontent.com/ansible/ansible/faf8fc62cb74f442c2446ac6f5798cecd107feff/lib/ansible/plugins/inventory/netbox.py)
- [nmap.pyc](https://raw.githubusercontent.com/ansible/ansible/68b981ae21f85e96d951aefac6acd1b0d169cefe/lib/ansible/plugins/inventory/nmap.py)

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

