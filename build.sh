#!/bin/bash

set -e

docker build -t edyan_adminer_test .
echo ""
echo ""
echo -e "\x1b[1;32mBuild Done. To run it: \e[0m"
echo '  docker run --rm  --name adminer-test-ctn edyan_adminer_test'
echo ""
echo "Or if you want to directly enter the container to run some commands: "
echo '  docker run -ti --rm edyan_adminer_test /bin/sh'
