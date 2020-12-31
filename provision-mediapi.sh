#!/bin/bash

ansible-playbook -i hosts provision-mediapi.yml "$@"
