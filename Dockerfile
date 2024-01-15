# Use a light Alpine Linux image with OpenJDK
FROM openjdk:11-alpine

# Set the working directory
WORKDIR /app

# Install curl
RUN apk --no-cache add curl

# Download the latest release JAR from Clojars
ARG CLOJARS_GROUP=org/clojars/mtsbarbosa
ARG CLOJARS_ARTIFACT=firma-analysis
ARG CLOJARS_VERSION=0.0.7

RUN curl -o app.jar \
    "https://clojars.org/repo/${CLOJARS_GROUP}/${CLOJARS_ARTIFACT}/${CLOJARS_VERSION}/${CLOJARS_ARTIFACT}-${CLOJARS_VERSION}.jar"

ENV LEIN_PROFILE prod

# Expose the port that your application will run on
EXPOSE 8080

# Command to run the application
CMD ["sh", "-c", "java -jar app.jar with-profile +$LEIN_PROFILE"]
