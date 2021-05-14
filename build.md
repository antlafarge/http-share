# Build

    docker build -t http-share .

    docker buildx build --no-cache --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/http-share:latest --push .
