#!/bin/bash
update_container() {
	docker compose pull
	docker compose up -d
}

cd /home/matheus/containers
for d in ./*/
do 
	(cd $d && update_container)
done
