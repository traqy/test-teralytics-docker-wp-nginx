#!/bin/bash

echo "Back up script is under construction".

echo "Mount NFS 52.221.222.174:/var/shareddir"
mount -a

export SOURCE_DIR=/var/www/upload
export NFS_BACKUP_DIR=/mnt/acme-su-nfs

echo "rsync -az ${SOURCE_DIR} ${NFS_BACKUP_DIR}"
rsync -rltzuv ${SOURCE_DIR} ${NFS_BACKUP_DIR}