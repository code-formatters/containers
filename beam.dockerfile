FROM debian:bullseye-slim
RUN apt-get update && apt-get -y --no-install-recommends install \
      elixir \
 && true
RUN { echo "#!/bin/sh"; which mix | xargs -n 1 basename | xargs -n 1 echo echo; } >/usr/local/bin/formatters \
 && chmod +x /usr/local/bin/formatters
RUN useradd --create-home user
WORKDIR /home/user
USER user
CMD ["formatters"]
