FROM elixir:1.13.4

RUN mkdir warehouse
COPY . /warehouse
WORKDIR /warehouse

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --force
RUN mix do compile

CMD ["/warehouse/entrypoint.sh"]