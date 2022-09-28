FROM amazoncorretto
COPY ./target .
CMD [ "java", "-jar", "nr-example.jar"]
