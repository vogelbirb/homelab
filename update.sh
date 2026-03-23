#!/bin/bash
update_container() {
	docker compose pull
	docker compose up -d
}

cd /srv/docker
for d in ./*/
do 
	(cd $d && update_container)
done
