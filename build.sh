#!/bin/bash

set -e

docker build -t "adminer_test" .
echo ""
echo ""
echo -e "\x1b[1;32mBuild Done. To run it: \e[0m"
echo '  docker run --rm --hostname "adminer-test-ctn" --name "adminer-test-ctn" adminer_test'
echo ""
echo "Or if you want to directly enter the container to run some commands: "
echo '  docker run -ti --rm adminer_test /bin/sh'
