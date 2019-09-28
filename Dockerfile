FROM hikaruna/firebase-tools

# https://github.com/puckel/docker-airflow/issues/182#issuecomment-444683455
RUN mkdir -p /usr/share/man/man1 \
&& apt-get update && apt-get install -y \
openjdk-8-jre \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN firebase setup:emulators:firestore

WORKDIR /app

RUN echo -n 'rules_version = '2';\n\
service cloud.firestore {\n\
  match /databases/{database}/documents {\n\
    match /{document=**} {\n\
      allow read, write;\n\
    }\n\
  }\n\
}' > firestore.rules

RUN echo -n '{\n\
  "firestore": {\n\
    "rules": "firestore.rules"\n\
  },\n\
  "emulators": {\n\
    "firestore": {\n\
      "host": "0.0.0.0"\n\
    }\n\
  }\n\
}' > firebase.json

EXPOSE 8080
EXPOSE 8081

CMD [ "firebase", "emulators:start", "--only", "firestore" ]
