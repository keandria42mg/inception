FROM debian:bookworm

RUN apt-get update -y && apt-get install nginx -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
