# Test Java EE 8 (CDI, Bean Validation) with WildFly

## Goal

The goal of this docker image is to build a WildFly version that integrates some features of Java EE 8 before the official release.

This WildFly version is used to deploy the demo: <http://javademo.io>

## Java EE 8 JSR Supported

The current version of WildFly 10.1.0.Final is patched with:

- JSR 370 (CDI 2.0 - Weld 3.0.0). The official Weld 3.0.0.Final.Patch is used.
- JSR 380 (Bean Validation 2.0 - Hibernate Validator 6.0.0). The official hibernate-validator-6.0.0.Beta2 is used.

## Patch WildFly using Docker

We use a docker container to build the patched wildfly version and copy it to our system.
If you don't want to use docker you can simply manually execute the commands in Dockerfile.

Execute the followig commands in the current directory. A new WildFly version will be created in the docker image and copied in the current directory. The docker container and image will be deleted

- ```docker build -t javaee/wildfly-javaee8 .```
- ```docker run -d --name wildfly-javaee8 javaee/wildfly-javaee8```
- ```docker cp wildfly-javaee8:/app/wildfly-10.1.0.Patched.tar.gz .```
- ```docker rmi javaee/wildfly-javaee8 -f```
- ```docker rm -f wildfly-javaee8```