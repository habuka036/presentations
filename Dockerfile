FROM ubuntu:20.04

ENV PYTHON_VERSION 3.11.2
ENV GO_VERSION 1.21.0
ENV RUBY_VERSION 3.2.2
ENV RUBY_ABI_VERSION 3.2.0
ENV RABBIT_VERSION 3.0.3
ENV YUTAPON_VERSION 081d
ENV CICA_VERSION 5.0.3
ENV DEBIAN_FRONTEND=noninteractive

ENV HOME /root
ENV ANYENV_HOME $HOME/.anyenv
ENV ANYENV_ENV  $ANYENV_HOME/envs
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN apt update -q -y
RUN apt -y install curl git jq nkf make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils software-properties-common zip openssh-server net-tools libyaml-dev

RUN git clone https://github.com/anyenv/anyenv $ANYENV_HOME
ENV PATH $ANYENV_HOME/bin:$PATH
#RUN mkdir $ANYENV_ENV
#RUN anyenv init
RUN anyenv install --force-init

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
RUN wget -O yutapon_coding_${YUTAPON_VERSION}.zip http://www.net2-system.top/pc/font/yutapon_coding_${YUTAPON_VERSION}.zip && unzip yutapon_coding_${YUTAPON_VERSION}.zip && mv yutapon_coding_*${YUTAPON_VERSION}.ttf README.TXT /usr/share/fonts/truetype/yutapon/ && rm -f yutapon_coding_${YUTAPON_VERSION}.zip

RUN mkdir /usr/share/fonts/truetype/cica/
RUN wget -O Cica_v${CICA_VERSION}.zip https://github.com/miiton/Cica/releases/download/v${CICA_VERSION}/Cica_v${CICA_VERSION}.zip && unzip Cica_v${CICA_VERSION}.zip && mv COPYRIGHT.txt Cica-*.ttf LICENSE.txt /usr/share/fonts/truetype/cica/ && rm -f Cica_v${CICA_VERSION}.zip

RUN apt-get -y install vim
RUN sed -i -e "s/^PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config

RUN /etc/init.d/ssh start

RUN rm -rf /var/lib/apt/lists/*


