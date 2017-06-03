from openjdk:alpine

RUN apk update
RUN apk upgrade

# Download the current version of wildfly
ADD http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz /app/wildfly-10.1.0.Final.tar.gz

# Set the working directory to /app
WORKDIR /app

RUN tar -zxvf /app/wildfly-10.1.0.Final.tar.gz

## Download Bean Validation 2.0 Beta 2
ADD http://repo1.maven.org/maven2/org/hibernate/validator/hibernate-validator-modules/6.0.0.Beta2/hibernate-validator-modules-6.0.0.Beta2-wildfly-10.1.0.Final-patch.zip /app/beanvalidation-patch.zip

## Download CDI - WELD 3.0 Final
ADD http://download.jboss.org/weld/3.0.0.Final/wildfly-10.1.0.Final-weld-3.0.0.Final-patch.zip /app/weld-patch.zip

RUN ./wildfly-10.1.0.Final/bin/jboss-cli.sh --command="patch apply /app/beanvalidation-patch.zip"
RUN ./wildfly-10.1.0.Final/bin/jboss-cli.sh --command="patch apply /app/weld-patch.zip"

## Package the patched version of wildfly
WORKDIR /app/wildfly-10.1.0.Final
RUN tar -zcvf /app/wildfly-10.1.0.Patched.tar.gz .
