FROM debian:stretch as dynamic-link-lib

FROM buildpack-deps:stretch-curl as jar-get
RUN curl -O https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-firestore-emulator-v1.8.4.jar

FROM openjdk as jre-build
RUN jlink \
--add-modules \
java.base,\
java.desktop,\
java.logging,\
java.management,\
java.naming,\
java.sql,\
java.xml,\
jdk.httpserver,\
jdk.unsupported \
--compress=2 --output /jre

FROM scratch
COPY --from=dynamic-link-lib /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=dynamic-link-lib /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
COPY --from=jre-build /jre /jre
ENV PATH $PATH:/jre/bin
COPY --from=jar-get /cloud-firestore-emulator-v1.8.4.jar /

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/cloud-firestore-emulator-v1.8.4.jar" ]
