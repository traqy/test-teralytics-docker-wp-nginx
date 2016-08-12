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
  * CI/CD Jenkins
    * Build jenkins image acme-oss-jenkins

```
PROJECT_PATH=/Users/traqy/github/test-teralytics-docker-wp-nginx
cd ./oss/jenkins-server/
DOCKER_NAME=acme-oss-jenkins
docker build -t="traqy/${DOCKER_NAME}" .
```
  * NFS server
    * Build image
```
cd ./oss/nfs-server/docker && ./build.sh && cd ../../../
```   
   * Mockup Application
```
cd application-mock-up
DOCKER_NAME=acme-app-mockup
docker build -t="traqy/${DOCKER_NAME}" .
cd ..
```
   * Backup Job
```
cd backup-nfs-client
DOCKER_NAME=acme-oss-backup
docker build -t="traqy/${DOCKER_NAME}" .
```


 ## CI/CD Jenkins
  * Boot Jenkins Docker OSS for ACME using dockerOS Virtual Machine in local mac
    * Run jenkins container acme-oss-jenkins
```
docker rm ${DOCKER_NAME}
docker run -d -p 8080:8080 -p 50000:50000 --name=acme-oss-jenkins -v ${PROJECT_PATH}/oss/jenkins_home:/var/jenkins_home traqy/${DOCKER_NAME}
```
  * Browse http://192.168.99.100:8080/
  * Jenkins Example Screenshots
    * ![Image](./docs/acme-jenkins_screenshot.png?raw=true)

## To simulate mockup web application generating user data and daily backup
  * Run NFS remote server (Simulate University Remote NFS Server)
  * Run the mockup web app server container
    * Jenkins
      * http://192.168.99.100:8080/job/acme-mockup-app-deploy-container/
    * Manual local console terminal
  * Run Remote NFS server mockup as docker nfs server
```
./oss/nfs-server/start.sh /var/shareddir/
```
  * Run the daily backup job manually
    * http://192.168.99.100:8080/job/acme-nfs-backup-daily/
