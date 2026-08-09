# python_3.14.7-trixie_docker_dev_image
A development environment based on python3.14.7-trixie. SSH and vim are pre-installed.

# image build
execute tools\windows\build_image.bat

# docker run
execute tools\windows\start_up_container.bat

# stop & remove container
execute tools\windows\stop_container.bat

# attach on running container
execute tools\windows\attach_on_running_container.bat
or
docker exec --user dev -it my_ssh_container /bin/bash

# Connect to a running container via SSH
ssh dev@localhost -p 2222


dotfilesをシンボリックリンク化
ドットファイルのみ（. と .. を除外）を対象にし、上書き作成（-f）する
find ~/dotfiles -maxdepth 1 -name '.*' ! -name '.' ! -name '..' -exec ln -sf {} ~/ +

docker run後に実行する
projectディレクトリにて
git init

vimを起動して
'PluginInstall
