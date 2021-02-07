FROM ruby:2.7.1

ENV LANG=C.UTF-8\
    LANGUAGE=C.UTF-8\
    LC_ALL=C.UTF-8\
    TZ=America/Sao_Paulo

COPY sources.list /etc/apt/

RUN mkdir /gems

VOLUME /gems
VOLUME /workspace

ENTRYPOINT ["/workspace/.docker/api/docker-entrypoint.sh"]

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]