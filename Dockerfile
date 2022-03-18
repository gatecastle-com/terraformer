FROM hashicorp/terraform:1.1.7

RUN apk add git vim

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
