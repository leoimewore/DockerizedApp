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