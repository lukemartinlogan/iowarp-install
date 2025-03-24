docker build --no-cache -t iowarp-base docker -f docker/iowarp-base.Dockerfile
docker tag iowarp-base iowarp/iowarp-base:latest
# docker push iowarp/iowarp-base:latest
docker build --no-cache -t chimaera docker -f docker/deps.Dockerfile
docker tag chimaera iowarp/chimaera-deps:latest
# docker push iowarp/chimaera-deps:latest