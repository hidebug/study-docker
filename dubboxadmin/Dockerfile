FROM ubuntu:14.04.4 
ADD dubbo-admin-2.8.4.tar /opt/apache-tomcat-7.0.68/webapps/
ADD dubbo-monitor-simple-2.8.4.tar /opt/
ADD jdk-7u79-linux-x64.tar.gz /opt/
ADD apache-tomcat-7.0.68.tar.gz /opt/


ENV JAVA_HOME /opt/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

EXPOSE 8080 9090

#dubbo.jetty.directory
RUN mkdir /root/monitor

RUN echo "/opt/dubbo-monitor/bin/start.sh" >> /root/start.sh && \
    echo "/opt/apache-tomcat-7.0.68/bin/catalina.sh run" >> /root/start.sh && \
    chmod u+x /root/start.sh

CMD /root/start.sh

