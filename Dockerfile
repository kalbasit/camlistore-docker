FROM golang:1.4.2
MAINTAINER Wael Nasreddine <wael.nasreddine@gmail.com>

ENV VERSION 0.8

RUN curl -sqLf https://github.com/camlistore/camlistore/archive/${VERSION}.tar.gz \
  | tar xzf - -C /usr/src \
  && cd /usr/src/camlistore-${VERSION} \
  && make \
  && mv bin/* /bin \
  && cd / \
  && rm -rf /usr/src/camlistore-${VERSION} \
  && adduser --disabled-password --quiet --gecos Camli camli

USER camli
ENV USER camli

VOLUME /home/camli
WORKDIR /home/camli

EXPOSE 80 443 3179 8080
CMD ["/bin/camlistored", "-listen", ":80"]
