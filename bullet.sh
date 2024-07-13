#!/bin/bash
echo "StayInTarkov Docker by bullet"

if [ -d "/opt/srv" ]; then
	start=$(date +%s)
	echo "Started copying files to your volume/directory.. Please wait."
	cp -r /opt/srv/* /opt/server/
	rm -r /opt/srv
	touch /opt/server/delete_me
	end=$(date +%s)
	
	echo "Files copied to your machine in $(($end-$start)) seconds."
	echo "Starting the server to generate all the required files"
	cd /opt/server
	chown $(id -u):$(id -g) ./* -Rf
	nohup timeout --preserve-status 25s ./SPT.Server.exe >/dev/null 2>&1 
	sleep 10
	sed -i 's/127.0.0.1/0.0.0.0/g' /opt/server/SPT_Data/Server/configs/http.json
	echo "Follow the instructions to proceed!"
	exit 0
fi

if [ -e "/opt/server/delete_me" ]; then
	echo "Error: Safety file found. Exiting."
	echo "Please follow the instructions."
	exit 1
fi

cd /opt/server && ./SPT.Server.exe

echo "Exiting."
exit 0
