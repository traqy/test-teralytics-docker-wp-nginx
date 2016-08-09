FROM ubuntu:14.04

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Setup mock-up application
RUN mkdir -p /var/www/upload
RUN mkdir /root/scripts
COPY apps.sh /root/scripts/
#RUN /root/scripts/apps.sh