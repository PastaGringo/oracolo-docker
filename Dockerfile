FROM node:alpine as build
RUN apk add --no-cache git nginx
RUN git clone https://github.com/dtonon/oracolo.git /app
WORKDIR /app
COPY entrypoint.sh /app/
COPY nginx.conf /app/
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT [ "/app/entrypoint.sh" ]
EXPOSE 8080/tcp
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]