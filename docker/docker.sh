docker build --no-cache -t iowarp-base docker -f docker/iowarp-base.Dockerfile
docker tag iowarp-base iowarp/iowarp-base:latest
# docker push iowarp/iowarp-base:latest
docker build --no-cache -t iowarp-deps docker -f docker/iowarp-deps.Dockerfile
docker tag iowarp-deps iowarp/iowarp-deps:latest
# docker push iowarp/iowarp-deps:latest
docker build --no-cache -t iowarp-dev docker -f docker/iowarp-dev.Dockerfile
docker tag iowarp-dev iowarp/iowarp-dev:latest
# docker push iowarp/iowarp-dev:latest
docker build --no-cache -t iowarp-user docker -f docker/iowarp-user.Dockerfile
docker tag iowarp-dev iowarp/iowarp-user:latest
# docker push iowarp/iowarp-user:latest
