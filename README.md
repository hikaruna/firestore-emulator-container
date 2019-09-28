# firestore-emulator-container

## Usage

```console
$ docker run -it --rm -p 8080:8080 -p 8081:8081 hikaruna/firestore-emulator
```

### customize firestore.rules

```console
$ docker run -it --rm -p 8080:8080 -p 8081:8081 -v ${your_dir}/firestore.rules:/app/firestore.rules hikaruna/firestore-emulator
```

Default rule is test mode.

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}
```

### customize firebase.json

```console
$ docker run -it --rm -p 8080:8080 -p 8081:8081 -v ${your_dir}/firebase.json:/app/firebase.json hikaruna/firestore-emulator
```

Default is

```json
{
  "firestore": {
    "rules": "firestore.rules"
  },
  "emulators": {
    "firestore": {
      "host": "0.0.0.0"
    }
  }
}
```

### log get

```console
$ touch ${your_dir}/firestore-debug.log
$ docker run -it --rm -p 8080:8080 -p 8081:8081 -v ${your_dir}/firestore-debug.log:/app/firestore-debug.log hikaruna/firestore-emulator
```
