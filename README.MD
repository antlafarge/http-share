# HTTP-SHARE

Share a directory through HTTP (protected by htaccess password) by using nginx.

## Docker

<pre>
# Create the login/password to access the http share.
echo "<b>&#60;LOGIN&#62;</b>:$(perl -le 'print crypt("<b>&#60;PASSWORD&#62;</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
        --name <b>&#60;CONTAINER-NAME&#62;</b> \
        --restart <b>&#60;RESTART&#62;</b> \
    -v <b>&#60;PATH&#62;</b>:/usr/share/nginx/html/<b>&#60;SHARE-NAME&#62;</b>:ro \
    -v ~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro \
        -p <b>&#60;PORT&#62;</b>:80 \
    antlafarge/http-share:latest
</pre>
*Parameters indented twice are optional.*

- Replace **`<LOGIN>`** and **`<PASSWORD>`** by the login and password which will be required to access the http share.
- Replace **`<CONTAINER-NAME>`** by the name you want for the container.
- Replace **`<RESTART>`** by `on-failure`, `unless-stopped` or `always`.
- Replace **`<PORT>`** by the http port you will open in your router NAT.
- Replace **`<PATH>`** by the absolute path to the directory you want to share and **`<SHARE-NAME>`** by the name you want for the shared directory. The share-name is optional if you need to share only 1 directory. You can add many volumes if you want to share multiple directories (see examples).

*Note : Do not delete the file `http-share.htpasswd` on your host machine, it will be used by the container.*

### Example

<pre>
# Create the login/password to access the http share.
echo "<b>admin</b>:$(perl -le 'print crypt("<b>MyGreatPassword</b>", "1xzcq")')" > ~/http-share.htpasswd

docker run -d \
        --name http-share \
        --restart <b>on-failure:2</b> \
    -v "<b>/mnt/hdd/public</b>:/usr/share/nginx/html/<b>Public</b>:ro" \
    -v "<b>/mnt/hdd/shared</b>:/usr/share/nginx/html/<b>Shared</b>:ro" \
    -v "~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro" \
        -p <b>8080</b>:80 \
    antlafarge/http-share:latest
</pre>
*Parameters indented twice are optional.*

## Docker compose

<pre>
echo "<b>&#60;LOGIN&#62;</b>:$(perl -le 'print crypt("<b>&#60;PASSWORD&#62;</b>", "1xzcq")')" > ~/http-share.htpasswd
</pre>

<pre>
services:
    http-share:
        image: antlafarge/http-share:latest
        container_name: <b>&#60;CONTAINER-NAME&#62;</b> # optional
        restart: <b>&#60;RESTART&#62;</b> # optional
        volumes:
            - "<b>&#60;PATH&#62;</b>:/usr/share/nginx/html/<b>&#60;SHARE-NAME&#62;</b>:ro"
            - "~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro"
        ports:
            - "<b>&#60;PORT&#62;</b>:80" # optional
</pre>

### Example

<pre>
echo "<b>admin</b>:$(perl -le 'print crypt("<b>MyGreatPassword</b>", "1xzcq")')" > ~/http-share.htpasswd
</pre>

<pre>
services:
    http-share:
        image: antlafarge/http-share:latest
        container_name: <b>http-share</b> # optional
        restart: <b>on-failure:2</b> # optional
        volumes:
            - "<b>/mnt/hdd/public</b>:/usr/share/nginx/html/<b>Public</b>:ro"
            - "<b>/mnt/hdd/shared</b>:/usr/share/nginx/html/<b>Shared</b>:ro"
            - "~/http-share.htpasswd:/etc/nginx/conf.d/.htpasswd:ro"
        ports:
            - "<b>8080</b>:80" # optional
</pre>

## Docker commands reminder

### Container stop

<pre>
docker stop <b>http-share</b>
</pre>

### Container restart

<pre>
docker restart <b>http-share</b>
</pre>

### Container logs

<pre>
docker logs --follow --tail 100 <b>http-share</b>
</pre>

### Container delete

<pre>
docker rm -f <b>http-share</b>
</pre>

### Image delete

<pre>
docker rmi antlafarge/http-share:<b>latest</b>
</pre>

### Compose start

<pre>
cd /path/to/docker-compose.yml/directory/
docker compose up -d
</pre>

### Compose stop

<pre>
cd /path/to/docker-compose.yml/directory/
docker compose down
</pre>
