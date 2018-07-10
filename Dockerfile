FROM ubuntu:16.04

ENV PYTHON_VERSION 2.7.15
ENV GO_VERSION 1.10.3
ENV RUBY_VERSION 2.5.1
ENV RUBY_ABI_VERSION 2.5.0
ENV RABBIT_VERSION 2.2.1
ENV YUTAPON_VERSION 081

ENV HOME /root
ENV ANYENV_HOME $HOME/.anyenv
ENV ANYENV_ENV  $ANYENV_HOME/envs
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN apt-get update -q -y
RUN apt-get -y install curl git jq nkf make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils software-properties-common zip openssh-server net-tools

RUN git clone https://github.com/riywo/anyenv $ANYENV_HOME
ENV PATH $ANYENV_HOME/bin:$PATH
RUN mkdir $ANYENV_ENV

RUN anyenv install pyenv
ENV PATH $ANYENV_ENV/pyenv/bin:$ANYENV_ENV/pyenv/shims:$PATH
ENV PYENV_ROOT $ANYENV_ENV/pyenv

RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN pyenv rehash

RUN anyenv install rbenv
ENV PATH $ANYENV_ENV/rbenv/bin:$ANYENV_ENV/rbenv/shims:$PATH
ENV RBENV_ROOT $ANYENV_ENV/rbenv

RUN rbenv install $RUBY_VERSION
RUN rbenv global $RUBY_VERSION
RUN rbenv rehash

RUN pip install awscli

RUN gem install rabbit rabbirack

RUN touch /root/.Xauthority
RUN mkdir $RBENV_ROOT/versions/$RUBY_VERSION/lib/ruby/gems/$RUBY_ABI_VERSION/gems/rabbit-${RABBIT_VERSION}/lib/rabbit/theme/eucalyptusja
RUN mkdir $RBENV_ROOT/versions/$RUBY_VERSION/lib/ruby/gems/$RUBY_ABI_VERSION/gems/rabbit-${RABBIT_VERSION}/data/rabbit/image/eucalyptusja-images
COPY rabbit-themes/eucalyptusja/* $RBENV_ROOT/versions/$RUBY_VERSION/lib/ruby/gems/$RUBY_ABI_VERSION/gems/rabbit-${RABBIT_VERSION}/lib/rabbit/theme/eucalyptusja/
COPY rabbit-themes/eucalyptusja-images/* $RBENV_ROOT/versions/$RUBY_VERSION/lib/ruby/gems/$RUBY_ABI_VERSION/gems/rabbit-${RABBIT_VERSION}/data/rabbit/image/eucalyptusja-images/

RUN mkdir /usr/share/fonts/truetype/yutapon/
RUN wget -O yutapon_coding_${YUTAPON_VERSION}.zip http://net2.system.to/pc/cgi-bin/download.cgi?file=yutapon_coding_${YUTAPON_VERSION}.zip && unzip yutapon_coding_${YUTAPON_VERSION}.zip && mv yutapon_coding_${YUTAPON_VERSION}.ttc README.TXT /usr/share/fonts/truetype/yutapon/ && rm -f yutapon_coding_${YUTAPON_VERSION}.zip

RUN apt-get -y install vim
RUN sed -i -e "s/^PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config

RUN /etc/init.d/ssh start

RUN rm -rf /var/lib/apt/lists/*


