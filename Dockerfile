FROM amazoncorretto

COPY ./target .

ADD ./newrelic/newrelic.yml .
ADD ./newrelic/newrelic.jar ./newrelic.jar
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:./newrelic.jar"

CMD [ "java","-javaagent:./newrelic.jar", "-jar", "nr-example.jar"]
