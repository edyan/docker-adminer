#!/bin/bash

set -e

TAG=edyan/adminer:latest

echo "Building ${TAG}"
docker build -t ${TAG} .

echo -e "${GREEN}Build Done${NC}."
echo ""
echo "Run :"
echo "  docker run -d --rm --name adminer${VERSION}-test-ctn ${TAG}"
echo "  docker exec -i -t adminer${VERSION}-test-ctn /bin/ash"
echo "Once Done : "
echo "  docker stop adminer${VERSION}-test-ctn"
echo ""
echo "Or if you want to directly enter the container, then remove it : "
echo "  docker run -ti --rm ${TAG} /bin/ash"
echo "To push that version (and other of the same repo):"
echo "docker push edyan/adminer"
