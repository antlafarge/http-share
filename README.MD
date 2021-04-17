# HTTP-SHARE

## Share a directory through HTTP.

## Run

<pre>
echo "<b>&#60;LOGIN&#62;</b>:$(perl -le 'print crypt("<b>&#60;PASSWORD&#62;</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
    --name http-share \
    -p <b>&#60;PORT&#62;</b>:80 \
    -v <b>&#60;PATH&#62;</b>:/usr/share/nginx/html:ro \
    -v ~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro \
    antlafarge/http-share:latest
</pre>

- Replace **`<LOGIN>`** and **`<PASSWORD>`** by the login and password which will be required to access the http share.
- Replace **`<PATH>`** by the absolute path to the directory you want to share.
- Replace **`<PORT>`** by the http port you will open in your router NAT.

### Example

<pre>
echo "<b>admin</b>:$(perl -le 'print crypt("<b>MyGreatPassword</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
    --name http-share \
    -p <b>8080</b>:80 \
    -v <b>/mnt/hdd/public</b>:/usr/share/nginx/html:ro \
    -v ~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro \
    antlafarge/http-share:latest
</pre>

## Build

    docker build -t http-share .

    docker buildx build --no-cache --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/http-share:latest --push .
