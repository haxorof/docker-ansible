#!/usr/bin/env bash
ansible -i hosts -m raw -a "cat /etc/os-release" $@ test