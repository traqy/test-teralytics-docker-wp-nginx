# backup

Backup mounted local volume to NFS remote shared mount volume

# Build a Docker image container for running the backup job
```
DOCKER_NAME=acme-oss-backup
docker build -t="traqy/${DOCKER_NAME}" .
```

# Run the backup nfs client container to mount nfs remote shareddir
```
docker rm ${DOCKER_NAME}
docker run -it -P --privileged=true -v /Users/traqy/github/test-teralytics-docker-wp-nginx/volume-data/upload:/var/www/upload --name=${DOCKER_NAME} traqy/${DOCKER_NAME}  /root/scripts/backup.sh
```

# Run i the back client container in the background
```
docker run -P --privileged=true -v /Users/traqy/github/test-teralytics-docker-wp-nginx/volume-data/upload:/var/www/upload --name=acme-backup-nfs-client traqy/acme-backup-nfs-client
```