FROM debian:bullseye-slim
RUN apt-get update && apt-get -y --no-install-recommends install \
      python3 \
      python3-pip \
 && true
RUN pip3 install --no-cache-dir --root / \
      beautysh \
      black \
      cmake-format \
      fprettify \
      resfmt \
      sqlparse \
      yapf \
 && true
RUN { echo "#!/bin/sh"; which beautysh black cmake-format fprettify resfmt sqlformat yapf | xargs -n 1 basename | xargs -n 1 echo echo; } >/usr/local/bin/formatters \
 && chmod +x /usr/local/bin/formatters
RUN useradd --create-home user
WORKDIR /home/user
USER user
CMD ["formatters"]
