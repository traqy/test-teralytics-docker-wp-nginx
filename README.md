# Teralytics Technical Challenge

## Proposal for ACME Singapore University Web Application
  * Architectural Diagram
    * ![Image](./docs/acme-aws-diagram.png?raw=true)
  * AWS Infrastructure Resource Stack 
    * EC2 Instances (Autoscale)
    * Elastic Load Balancer (ELB)
    * Elastic Block Store (EBS)
    * Route53 DNS
    * ClpudWatch Free Tier
    * For future consideration
      * Optional S3 Backup
      * Optional Glacier Permanent Backup
      * EFS
  * [Cost and Sizing](https://github.com/traqy/test-teralytics-docker-wp-nginx/raw/acme-su-webapp/docs/Tera-Test%20ACME-SU%20Proposal.xlsx)


## Backup Script Deployment
### Implementation using Docker and Assumptions
  * Remote NFS Server Shared Storage for offsite backup.
```
52.221.222.174:/var/shareddir
```
  * Source data directory
```
/var/www/upload
```
  * Backup Scripts Runs on a Docker container
    * Ideally this bash script docker container should be run in one of the EC2 instances as the Docker host machine. For the sake of validating the functionality, we will use local desktop machine with VM DockerOS.
  * I prefer to run the backup script using Jenkins jobs with the following automated integration below. 
      * Send Slack alert notification message
      * JIRA automated creation of ticket

### Build Docker Images for the following stack:
  * CI/CD Jenkins (traqy/acme-oss-jenkins)
```
PROJECT_PATH=/Users/traqy/github/test-teralytics-docker-wp-nginx
cd ./oss/jenkins-server/
DOCKER_NAME=acme-oss-jenkins
docker build -t="traqy/${DOCKER_NAME}" .
```
  * NFS server (traqy/acme-oss-nfs-server)
```
DOCKER_NAME=acme-oss-nfs-server
cd ./oss/nfs-server/docker && ./build.sh && cd ../../../
```   
   * Mockup Application (traqy/acme-app-mockup)
```
cd application-mock-up
DOCKER_NAME=acme-app-mockup
docker build -t="traqy/${DOCKER_NAME}" .
cd ..
```
   * Backup Job (traqy/acme-oss-backup-job)
```
cd backup-nfs-client
DOCKER_NAME=acme-oss-backup-job
docker build -t="traqy/${DOCKER_NAME}" .
```

## Boot CI/CD Jenkins

  * Boot Jenkins Docker OSS for ACME using dockerOS Virtual Machine in local mac
    * Run jenkins container acme-oss-jenkins
```
DOCKER_NAME=acme-oss-jenkins

docker ps -a | grep "${DOCKER_NAME}" | awk '{print $1}' | xargs docker rm
docker run -d -p 8080:8080 -p 50000:50000 --name=acme-oss-jenkins -v ${PROJECT_PATH}/oss/jenkins_home:/var/jenkins_home traqy/${DOCKER_NAME}
```
  * Browse http://192.168.99.100:8080/
  * Jenkins Example Screenshots
    * ![Image](./docs/acme-jenkins_screenshot.png?raw=true)

## Backup Simulation

### Summary Implementation Outline

  * NFS
  * Run mockup web server in the background
  * Run backup job

### Sequence of actions
  * Define acme-su-net subnet
```
docker network create --subnet=172.18.0.0/16 acme-su-net
```
  * Run NFS remote server (Simulate University Remote NFS Server)
```
DOCKER_NAME=acme-oss-nfs-server

docker ps -a | grep "${DOCKER_NAME}" | awk '{print $1}' | xargs docker rm
cd oss/nfs-server 
./start.sh /var/shareddir 
cd ../../
docker ps
```
  * Run the mockup web app server container
    * Via Jenkins
      * http://192.168.99.100:8080/job/acme-mockup-app-deploy-container/
  * Run the daily backup job manually
    * http://192.168.99.100:8080/job/acme-nfs-backup-daily/

### Validation

  * Check remote NFS server. Verify if the files are backed up.
