FROM adoptopenjdk/openjdk11:latest

# Set the working directory
WORKDIR /app

# Install curl
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Download the latest release JAR from Clojars
ARG CLOJARS_GROUP=org/clojars/mtsbarbosa
ARG CLOJARS_ARTIFACT=firma-analysis
ARG CLOJARS_VERSION=0.0.9

RUN curl -o app.jar \
    "https://repo.clojars.org/${CLOJARS_GROUP}/${CLOJARS_ARTIFACT}/${CLOJARS_VERSION}/${CLOJARS_ARTIFACT}-${CLOJARS_VERSION}.jar"

ENV LEIN_PROFILE prod

# Expose the port that your application will run on
EXPOSE 8080

# Command to run the application
CMD ["sh", "-c", "java -jar app.jar with-profile +$LEIN_PROFILE"]
