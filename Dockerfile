from openjdk:alpine

RUN apk update
RUN apk upgrade

RUN apk add --update curl

# Set the working directory to /app
WORKDIR /app

# Download the current version of wildfly
RUN curl -O http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz

RUN tar -zxvf /app/wildfly-10.1.0.Final.tar.gz

## Download Bean Validation 2.0 CR 3
RUN curl -O http://repo1.maven.org/maven2/org/hibernate/validator/hibernate-validator-modules/6.0.2.Final/hibernate-validator-modules-6.0.2.Final-wildfly-10.1.0.Final-patch.zip

## Download CDI - WELD 3.0 Final
RUN curl -O http://download.jboss.org/weld/3.0.1.Final/wildfly-10.1.0.Final-weld-3.0.1.Final-patch.zip

RUN ./wildfly-10.1.0.Final/bin/jboss-cli.sh --command="patch apply /app/hibernate-validator-modules-6.0.2.Final-wildfly-10.1.0.Final-patch.zip"
RUN ./wildfly-10.1.0.Final/bin/jboss-cli.sh --command="patch apply /app/wildfly-10.1.0.Final-weld-3.0.1.Final-patch.zip"

## Package the patched version of wildfly
WORKDIR /app/wildfly-10.1.0.Final
RUN tar -zcvf /app/wildfly-10.1.0.Patched.tar.gz .
