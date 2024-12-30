#!/bin/bash

curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.3/builds/82/downloads/paper-1.21.3-82.jar 

echo "Downloads completed"

java -Xmx4G -Xms4G -jar server.jar --nogui
