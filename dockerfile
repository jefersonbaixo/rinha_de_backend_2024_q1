FROM elixir:1.16.1

ENV MIX_ENV=prod

# Workaround QEMU JIT issue building AMD64 on ARM64
ENV ERL_FLAGS="+JPperf true"

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .

RUN mix deps.get && \
    mix compile

CMD ["mix", "phx.server"]
