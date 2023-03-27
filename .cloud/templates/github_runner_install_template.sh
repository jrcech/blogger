#!/usr/bin/env bash

mkdir /home/${UNIX_USERNAME}/actions-runner && cd /home/${UNIX_USERNAME}/actions-runner

curl -o actions-runner-linux-x64-2.303.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.303.0/actions-runner-linux-x64-2.303.0.tar.gz
echo "e4a9fb7269c1a156eb5d5369232d0cd62e06bec2fd2b321600e85ac914a9cc73  actions-runner-linux-x64-2.303.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.303.0.tar.gz

./config.sh --unattended --name $(echo "${GH_REPO}-$(date '+%Y-%m-%d_%H-%M-%S')") --url https://github.com/${GH_USERNAME}/${GH_REPO} --token ${GH_RUNNER_TOKEN}

sudo ./svc.sh install
sudo ./svc.sh start
