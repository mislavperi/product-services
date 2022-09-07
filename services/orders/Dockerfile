FROM elixir:1.13.4

RUN mkdir orders
COPY . /orders
WORKDIR /orders

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.clean snappyer
RUN mix deps.clean crc32cer
RUN mix deps.get --force
RUN mix do compile

CMD ["/orders/entrypoint.sh"]