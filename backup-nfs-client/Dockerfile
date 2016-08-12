FROM ubuntu:14.04

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get -y install wget telnet curl vim

# Install NFS client library
RUN apt-get -y install nfs-common 

# Install rsync 
RUN apt-get -y install rsync

# Configure /etc/fstab
RUN mkdir -p /mnt/acme-su-nfs
#RUN echo '52.221.222.174:/var/shareddir    /mnt/acme-su-nfs   nfs    nolock,rsize=8192,wsize=8192,timeo=14,intr' >> /etc/fstab
RUN echo '172.18.0.2:/exports/var/shareddir /mnt/acme-su-nfs nfs nolock,rsize=8192,wsize=8192,timeo=14,intr' >> /etc/fstab

# Upload volume data dir
RUN mkdir -p /var/www/upload

# Copy backup script
RUN mkdir /root/scripts
COPY backup.sh /root/scripts/

