#!/bin/bash

ansible-playbook -i hosts provision-serverpi.yml "$@"
