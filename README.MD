# HTTP-SHARE

Share a directory through HTTP.

## Run

<pre>
echo "<b>&#60;LOGIN&#62;</b>:$(perl -le 'print crypt("<b>&#60;PASSWORD&#62;</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
    --name <b>&#60;CONTAINER-NAME&#62;</b> \
    --restart <b>&#60;RESTART&#62;</b> \
    -p <b>&#60;PORT&#62;</b>:80 \
    -v <b>&#60;PATH&#62;</b>:/usr/share/nginx/html:ro \
    -v ~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro \
    antlafarge/http-share:latest
</pre>
*Note: Do not delete the file `http-share.htpasswd` on your host machine, it will be used by the container.*

- Replace **`<LOGIN>`** and **`<PASSWORD>`** by the login and password which will be required to access the http share.
- Replace **`<CONTAINER-NAME>`** by the name you want for the container.
- Replace **`<RESTART>`** by `on-failure`, `unless-stopped` or `always`.
- Replace **`<PORT>`** by the http port you will open in your router NAT.
- Replace **`<PATH>`** by the absolute path to the directory you want to share.

### Example

<pre>
echo "<b>admin</b>:$(perl -le 'print crypt("<b>MyGreatPassword</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
    --name http-share \
    --restart <b>on-failure:2</b> \
    -p <b>8080</b>:80 \
    -v <b>/mnt/hdd/public</b>:/usr/share/nginx/html:ro \
    -v ~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro \
    antlafarge/http-share:latest
</pre>

## Build

    docker build -t http-share .

    docker buildx build --no-cache --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/http-share:latest --push .
