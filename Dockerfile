FROM zookeeper:3.4.13

COPY sasl_jar_package/kafka-clients-1.1.0.jar /zookeeper-3.4.13/src/java/lib
COPY sasl_jar_package/lz4-java-1.4.jar /zookeeper-3.4.13/src/java/lib
COPY sasl_jar_package/slf4j-api-1.7.25.jar /zookeeper-3.4.13/src/java/lib
COPY sasl_jar_package/snappy-java-1.1.7.1.jar /zookeeper-3.4.13/src/java/lib
COPY zookeeper_jaas.conf /conf/zookeeper_jaas.conf

ENV AUTOPURGE_PURGEINTERVAL="org.apache.zookeeper.server.auth.SASLAuthenticationProvider" \
    AUTOPURGE_SNAPRETAINCOUNT="sasl" \
    JAASLOGINRENEW="3600000" \
    JVMFLAGS="-Djava.security.auth.login.config=/conf/zookeeper_jaas.conf"


COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/zkServer.sh", "start-foreground"]
