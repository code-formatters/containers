FROM debian:bullseye-slim
RUN apt-get update && apt-get -y --no-install-recommends install \
      ninja-build \
      nodejs \
      npm \
 && true
RUN npm install --global \
      bs-platform \
      lua-fmt \
      node-cljfmt \
      prettier \
      prettier-plugin-solidity \
      prettier-plugin-toml \
      @prettier/plugin-lua \
      @prettier/plugin-php \
      rescript \
      standard \
 && npm cache clean --force
RUN apt-get -y remove ninja-build npm openssl \
 && apt-get -y autoremove \
 && apt-get -y autoclean \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*
RUN { echo "#!/bin/sh"; which bsrefmt cljfmt luafmt prettier rescript standard | xargs -n 1 basename | xargs -n 1 echo echo; } >/usr/local/bin/formatters \
 && chmod +x /usr/local/bin/formatters
RUN useradd --create-home user
WORKDIR /home/user
USER user
CMD ["formatters"]
