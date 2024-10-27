# syntax=docker.io/docker/dockerfile:1.7-labs

FROM haskell:9.4.7 AS build

COPY --exclude=Dockerfile . /quizzer
WORKDIR /quizzer
RUN make build

FROM alpine
COPY --from=build --chmod=0711 /root/.local/bin/quizzer /bin/quizzer
RUN apk add gmp gcompat
CMD ["/bin/quizzer"]
