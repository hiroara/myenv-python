FROM hiroara/myenv:plain

# Build deps
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      build-essential \
      libbz2-dev \
      libffi-dev \
      liblzma-dev \
      libncurses5-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxmlsec1-dev \
      llvm \
      make \
      tk-dev \
      xz-utils \
      zlib1g-dev \
      && \
    rm -rf /var/lib/apt/lists/*

# Python
RUN curl https://pyenv.run | bash && \
    echo 'export PATH="/root/.pyenv/bin:$PATH"' >> $HOME/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc
ARG PYTHON_VERSION=3.9.0
RUN $HOME/.pyenv/bin/pyenv install $PYTHON_VERSION && \
    $HOME/.pyenv/bin/pyenv global $PYTHON_VERSION

COPY ./python/scripts/init.sh /tmp/python-init.sh

ENTRYPOINT ["/tmp/python-init.sh"]
CMD ["/bin/bash", "--login"]
