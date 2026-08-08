# python_3.14.7-trixie_docker_dev_image
A development environment based on python3.14.7-trixie. SSH and vim are pre-installed.

# image build
docker build -t ssh-dev-container \
    --build-arg git_user_name=wazatoki \
    --build-arg git_user_email=wazatoki@gmail.com \
    .

# docker run
docker run -d -p 2222:22 --name my_ssh_container \
    -v $HOME\.ssh\id_rsa.pub:/home/dev/.ssh/authorized_keys:ro \
    -v $HOME\docker\project:/home/dev/project \
    -v $HOME\docker\dotfiles\.vimrc:/home/dev/.vimrc \
    ssh-dev-container 

# stop & remove container
docker stop my_ssh_container
docker rm my_ssh_container

# attach on running container
docker exec --user dev -it my_ssh_container /bin/bash
ssh dev@localhost -p 2222


dotfilesをシンボリックリンク化
ドットファイルのみ（. と .. を除外）を対象にし、上書き作成（-f）する
find ~/dotfiles -maxdepth 1 -name '.*' ! -name '.' ! -name '..' -exec ln -sf {} ~/ +

docker run後に実行する
projectディレクトリにて
git init

vimを起動して
'PluginInstall
