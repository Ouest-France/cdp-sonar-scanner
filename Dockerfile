FROM openjdk:8-jre-alpine3.7

ARG SONAR_SCANNER_VERSION="3.1.0.1141"
ARG SONAR_SCANNER_DIR="/root"

ENV PATH="${PATH}:${SONAR_SCANNER_DIR}/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin"

RUN apk --update add --no-cache curl unzip sed && \
    curl -L https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip -o ${SONAR_SCANNER_DIR}/sonar-scanner.zip && \
    unzip ${SONAR_SCANNER_DIR}/sonar-scanner.zip -d ${SONAR_SCANNER_DIR} && \
    rm ${SONAR_SCANNER_DIR}/sonar-scanner.zip && \
    rm -rf ${SONAR_SCANNER_DIR}/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/jre && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' ${SONAR_SCANNER_DIR}/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner && \
    apk del curl unzip sed && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENTRYPOINT ["sonar-scanner"]
CMD ["--help"]
