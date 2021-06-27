## Build docker container for my app

To build image and run container use docker-compose:
```
docker-compose up
```

To test app in container using curl:
```
curl -H "Content-Type: application/json" -X POST -d '{"animal": "dog", "sound": "gau-gau", "count" : 6}' http://0.0.0.0:8080

🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau

Made with 💛 by Vadim
```

Size of container image: python:3.9-alpine image size 57.8MB