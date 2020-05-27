FROM alpine:3.9 AS build

ARG VERSION=0.70.0
ARG HUGO_DIRECTORY=./docs

ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN tar -zxvf hugo.tar.gz

COPY ${HUGO_DIRECTORY} /site
WORKDIR /site

RUN /hugo --minify

FROM nginx:1.15-alpine

WORKDIR /usr/share/nginx/html/

RUN rm -fr * .??*

COPY --from=build /site/public /usr/share/nginx/html
