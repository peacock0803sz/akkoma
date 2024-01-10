# syntax=docker/dockerfile:1

ARG ELIXIR_VER="1.15"
FROM elixir:${ELIXIR_VER}
ARG MIX_ENV
ENV MIX_ENV=${MIX_ENV}
SHELL ["/bin/bash", "-c"]

ARG WORK=/akkoma
WORKDIR ${WORK}

ENV DEBIAN_FRONTEND=noninteractive
ARG APT_PKGS
RUN \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt-get update && apt-get -yq upgrade \
  && apt-get install -y --no-install-recommends \
    build-essential cmake libmagic-dev libimage-exiftool-perl \
    postgresql-13 ffmpeg locales ${APT_PKGS} \
  && rm -rf /var/lib/apt/lists/*_* \
  && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen

ENV DATA=/var/lib/akkoma
ENV ETC=/etc/akkoma

COPY ./entrypoint.sh ${WORK}

COPY ./app ${WORK}
RUN mix local.hex --force && mix local.rebar --force \
  && mix deps.get --only ${MIX_ENV} \
  && mix deps.compile --force && mix compile \
  && mkdir -p ${ETC} ${DATA}/uploads ${DATA}/static

COPY ./config/ ${WORK}/config/

ENTRYPOINT ["/akkoma/entrypoint.sh"]
