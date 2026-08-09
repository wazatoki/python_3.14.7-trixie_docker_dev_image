rem build docker image

cd /d %~dp0
docker compose -f ..\docker\docker-compose.yml --env-file ..\..\.env build --no-cache