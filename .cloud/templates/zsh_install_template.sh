#!/usr/bin/env bash

sudo apt update && sudo apt install -q -y zsh expect

sudo chsh -s /bin/zsh ${UNIX_USERNAME}
