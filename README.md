# DockerizedApp

## Project was copied from this link: https://devopsrealtime.com/dockerize-a-java-web-application-using-docker-compose/

## Objectives
- The goal of this project to deploy Java application stack (Nginx, Tomcat, MySQL) using docker-compose
- Use Maven to build the JAVA project and deploy war file on Tomcat
- Create a dockerfile to build a tomcat image on amazonlinux with the proper dependencies

<img width="794" alt="image" src="https://github.com/leoimewore/DockerizedApp/assets/95531716/ac056b61-63fe-4119-8f62-77996a533120">


## Steps
- Install Maven and Java on my local terminal
- Fork and clone the Java app source code on my local machine : https://bitbucket.org/dptrealtime/java-login-app/src/master/
- Create a Dockerfile to build tomcat on linux
- Create docker-compose file with services for proxy-server, tomcat server and database
- Log into the SQL container and create DB Schema for the application

## Docker file to build tomcat on amazon linux
  ```
   FROM amazonlinux:2.0.20230727.0

    RUN mkdir /opt/tomcat/
    WORKDIR /opt/tomcat
    RUN yum install java-1.8.0-openjdk -y wget
    RUN yum install tar -y
    RUN yum install gzip -y
    RUN yum install wget -y
    RUN yum install mysql -y && yum -y install telnet
    
    ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz .
    RUN tar xvfz apache*.tar.gz
    
    RUN mv apache-tomcat-9.0.82/* /opt/tomcat
    
    COPY target/dptweb-1.0.war /opt/tomcat/webapps
    
    RUN rm /opt/tomcat/conf/tomcat-users.xml
    RUN rm /opt/tomcat/webapps/manager/META-INF/context.xml
    COPY tomcat-users.xml /opt/tomcat/conf/
    COPY context.xml /opt/tomcat/webapps/manager/META-INF/
    
    
    EXPOSE 8080 
    
    
    CMD ["/opt/tomcat/bin/catalina.sh","run"]

    BUILD with : docker build -it tomcat
    RUN Container  with: docker run -d -p 8080:8080 tomcat

    using http:localhost or IPAdd:8080 should give you


  ```
