# backup

Backup mounted local volume to NFS remote shared mount volume

# Build a Docker image container for running the backup job
```
docker build -t="traqy/acme-backup-nfs-client" .
```

# Run the backup nfs client container to mount nfs remote shareddir
```
docker rm acme-backup-nfs-client
docker run -it -P --privileged=true -v /Users/traqy/github/test-teralytics-docker-wp-nginx/volume-data/upload:/var/www/upload --name=acme-backup-nfs-client traqy/acme-su-webapp-backup  /root/scripts/backup.sh
```

