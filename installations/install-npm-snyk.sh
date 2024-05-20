#!/bin/bash
# Installing NPM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 15.0.0
node -e "console.log('Running Node.js ' + process.version)"
npm --version