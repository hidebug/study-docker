FROM ubuntu:14.04.4
add apache-tomcat-7.0.68.tar.gz /opt/
add jdk-7u79-linux-x64.tar.gz /opt/

ENV JAVA_HOME /opt/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

EXPOSE 8080

ENTRYPOINT ["/opt/apache-tomcat-7.0.68/bin/catalina.sh", "run"]







