FROM ubuntu:14.04.4
ADD zookeeper-3.4.6.tar.gz /opt/ 
RUN mv /opt/zookeeper-3.4.6 /opt/zookeeper
ADD zk/zoo.cfg /opt/zookeeper/conf
RUN mkdir /root/zookeeper

ADD jdk-7u79-linux-x64.tar.gz /opt/
RUN mv /opt/jdk1.7.0_79 /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:$JAVA_HOME/bin

ADD apache-tomcat-7.0.68.tar.gz /opt/
RUN mv /opt/apache-tomcat-7.0.68  /opt/tomcat

ADD serf_0.7.0_linux_amd64.tar  /bin/
ENV SERF_CONFIG_DIR /etc/serf
ADD serf/* $SERF_CONFIG_DIR/
ADD handlers $SERF_CONFIG_DIR/handlers
RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh

RUN apt-get update && \
    apt-get install -y dnsmasq
ADD dnsmasq/* /etc/

#system date
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    ntpdate time.nist.gov && \
    echo "0-59/10 * * * * /usr/sbin/ntpdate us.pool.ntp.org | logger -t NTP" >> /etc/crontab


EXPOSE 8080 2888 3888 2181 22 7373 7946 

RUN echo "/opt/zookeeper/bin/zkServer.sh start" >> /root/boot.sh && \
    echo "/etc/serf/start-serf-agent.sh > serf_log &" >> /root/boot.sh && \
    echo "/opt/tomcat/bin/catalina.sh run" >> /root/boot.sh && \
    chmod u+x /root/boot.sh

CMD /root/boot.sh

