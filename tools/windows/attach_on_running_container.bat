rem attach on running container

cd /d %~dp0
docker compose -f ..\docker\docker-compose.yml --env-file ..\..\.env exec --user dev my_ssh_container /bin/bash