FROM python:3.14.7-trixie

ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

# 必要なパッケージのインストールとタイムゾーン設定の自動化
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
	tmux \
	vim \
	git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-openssl \
	python3-venv \
    task-japanese \
    locales-all\
    && rm -rf /var/lib/apt/lists/*

# ロケールの設定
ENV LANG=ja_JP.UTF-8

# 'dev' ユーザーの作成（パスワードなし、sudo権限付き）
RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	
USER dev

# SSH公開鍵を配置するディレクトリの準備
RUN mkdir -p /home/dev/.ssh && \
    chmod 700 /home/dev/.ssh

# projectディレクトリの作成
RUN mkdir -p /home/dev/project && \
    chown dev:dev /home/dev/project && \
    chmod 700 /home/dev/project
	
# vim設定ディレクトリの準備
RUN curl -fLo /home/dev/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR /home/dev/project

RUN git config --global user.name GIT_USER_NAME && \
    git config --global user.email GIT_USER_EMAIL && \
	git config --global init.defaultBranch main && \
	git config --global --add safe.directory /home/dev/project

# コンテナ起動時にSSHサービスをフォアグラウンドで実行
USER root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]