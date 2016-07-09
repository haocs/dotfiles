FROM ubuntu

MAINTAINER haoc

RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends\
      apt-transport-https \
      build-essential \
      ca-certificates \
      git \
      lsb-release \
      rlwrap \
      vim

ADD . /.dotfiles

# Trim sudo since docker does not require it
RUN cd /.dotfiles && \
	sed -e 's/sudo//g' ./scripts/setup_deb.sh >> ./scripts/test_deb.sh && \
	chmod +x ./scripts/test_deb.sh

