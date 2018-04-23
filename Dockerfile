FROM openjdk:8-jre-alpine3.7

ARG VERSION_GIT="2.15.0-r1"
ARG VERSION_OPENSSH="7.5_p1-r8"
ARG VERSION_SONAR_SCANNER="3.1.0.1141"
ARG DIR_SONAR_SCANNER="/root"

ENV PATH="${PATH}:${DIR_SONAR_SCANNER}/sonar-scanner-${VERSION_SONAR_SCANNER}-linux/bin"

RUN apk --update add --no-cache curl unzip sed git=$VERSION_GIT openssh=$VERSION_OPENSSH && \
    curl -L https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${VERSION_SONAR_SCANNER}-linux.zip -o ${DIR_SONAR_SCANNER}/sonar-scanner.zip && \
    unzip ${DIR_SONAR_SCANNER}/sonar-scanner.zip -d ${DIR_SONAR_SCANNER} && \
    rm ${DIR_SONAR_SCANNER}/sonar-scanner.zip && \
    rm -rf ${DIR_SONAR_SCANNER}/sonar-scanner-${VERSION_SONAR_SCANNER}-linux/jre && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' ${DIR_SONAR_SCANNER}/sonar-scanner-${VERSION_SONAR_SCANNER}-linux/bin/sonar-scanner && \
    apk del curl unzip sed && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENTRYPOINT ["sonar-scanner"]
CMD ["--help"]
