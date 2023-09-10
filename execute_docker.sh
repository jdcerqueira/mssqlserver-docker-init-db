#!/bin/bash

docker run -d --network host --name sql -v $(pwd)/data/:/var/opt/mssql/data/ financeiro-db:1.0
echo "Docker iniciado."