FROM elixir:1.13.4

RUN mkdir main
COPY . /main
WORKDIR /main

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.clean snappyer
RUN mix deps.clean crc32cer
RUN mix deps.get --force
RUN mix do compile

CMD ["/main/entrypoint.sh"]
