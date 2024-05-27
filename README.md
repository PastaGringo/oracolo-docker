# oracolo-docker

You need to use your own web proxy to access the container with HTTPS.

## Use with docker-compose:

```
version: '3.8'
services:

  oracolo:
    container_name: oracolo
    #image: pastagringo/oracolo-docker
    build:
      context: .
    environment:
      - NPUB=npub1ky4kxtyg0uxgw8g5p5mmedh8c8s6sqny6zmaaqj44gv4rk0plaus3m4fd2
      - RELAYS="wss://nostr.fractalized.net, wss://rnostr.fractalized.net"
      - TOP_NOTES_NB=3
    # ports:
    #   - 8080:8080
```

Live demo: [oracolo.fractalized.net](oracolo.fractalized.net/)