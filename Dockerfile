FROM node:alpine as build
RUN apk add --no-cache git
RUN git clone https://github.com/dtonon/oracolo.git /build
WORKDIR /build
RUN npm install
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /build/dist/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8080/tcp
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]