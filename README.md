# Teralytics Technical Challenge

## Proposal for ACME Singapore University Web Application
  * [Architectural Diagram](https://github.com/traqy/test-teralytics-docker-wp-nginx/raw/acme-su-webapp/docs/acme-aws-diagram.png)
  * AWS Infrastructure Resource Stack 
    * EC2 Instances
    * Elastic Load Balancer (ELB)
    * Elastic Block Store (EBS)
    * Route53 DNS
    * Optional S3 Backup
    * Optional Glacier Permanent Backup
  * [Cost and Sizing](https://github.com/traqy/test-teralytics-docker-wp-nginx/raw/acme-su-webapp/docs/Tera-Test%20ACME-SU%20Proposal.xlsx)


## Backup Script Deployment
### Assumptions
  * Remote NFS Server Shared Storage for offsite backup
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
 ## CI/CD Jenkins
  * Boot Jenkins Docker OSS for ACME using dockerOS Virtual Machine in local mac
```
docker run -p 8080:8080 -p 50000:50000 -v /Users/traqy/github/docker/jenkins_home:/var/jenkins_home traqy/jenkins-acme-oss:v1
```
  * Browse http://192.168.99.100:8080/
  * 
