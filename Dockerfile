FROM adoptopenjdk/openjdk11:alpine-slim AS overlay

RUN mkdir -p memory-overlay
COPY ./src memory-overlay/src/
COPY ./gradle/ memory-overlay/gradle/
COPY ./gradlew ./settings.gradle ./build.gradle ./gradle.properties /memory-overlay/

RUN mkdir -p ~/.gradle \
    && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties \
    && echo "org.gradle.configureondemand=true" >> ~/.gradle/gradle.properties \
    && cd memory-overlay \
    && chmod 750 ./gradlew \
    && ./gradlew --version;

RUN cd memory-overlay \
    && ./gradlew clean build --parallel;

FROM adoptopenjdk/openjdk11:alpine-slim AS build

LABEL "Description"="Memory Test Service"

RUN cd / \
    && mkdir -p memory-overlay;

COPY --from=overlay memory-overlay/build/libs/memory.jar memory-overlay/

EXPOSE 8080

ENV PATH $PATH:$JAVA_HOME/bin:.

WORKDIR memory-overlay
ENTRYPOINT ["java", "-jar", "memory.jar"]
