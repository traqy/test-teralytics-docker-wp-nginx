FROM centos:6

# Keep upstart from complaining

# Basic Requirements
RUN yum install -y nfs-utils nfs-utils-lib chkconfig
#RUN chkconfig nfs on 
#RUN service rpcbind start
#RUN service nfs start

# Configure /etc/exports
RUN mkdir -p /var/shareddir
RUN echo '/var/shareddir 172.31.27.0/24(rw,sync,no_root_squash,no_all_squash)' > /etc/exports


