This is a fork of https://github.com/Juriy/easyio to make it work with docker.

# EASYIO
A simple application to test REST and SocketIO connectivity and experiment with node.js deployement models. This is an accompanying app 
for YouTube series - **"Deploying Node"** https://www.youtube.com/playlist?list=PLQlWzK5tU-gDyxC1JTpyC2avvJlt3hrIh

Check out the deployed version at https://nanogram.io (NOT WORKING ANYMORE)

# API
An application exposes REST and SocketIO APIs

## REST API

`GET /api/test ` - dumps request headers as well as remote IP as seen by node.js app (good to test if proxy passes the IP)

`GET /api/name ` - responds with the node name (see command line parameters above)

`GET /api/info ` - responds with app version, reading it from `version.txt` file or 0 if no file is present, value of `__dirname` and `process.cwd()`. Useful to see which version is being served and where is it served from

## SocketIO API
For every connected client, an application listens to `heartbeat` event. Once event is received, server will send back `heartbeat` event with the same payload as client sent, adding the name of the node that processed event. Useful to test socket.io connectivity as well as roundtrip times.

###########################################
<p>To get it running:

``` docker run -d -p 8080:8080 --name readyio-fork --restart=unless-stopped pedrobuffon/easyio-fork:latest ```

<p>or you can run it with a docker compose as well:

```
version: '3.6'
services:
  easyio-fork:
    container_name: easyio-fork
    image: pedrobuffon/easyio-fork:latest
    restart: unless-stopped
    network_mode: bridge
    labels:
      - "com.centurylinklabs.watchtower.monitor-only=true"
    ports:
      - 9090:8080
    environment:
      - PUID=1000 #optional
      - PGID=1000 #optional
      - WEB_PORT=8080 #optional
      - WEB_NAME=testname #optional
```
<table>
    <thead>
    <tr>
    <th>Environment Variable</th>
    <th>Example Value</th>
    <th>Description</th>
    <th>Default Value</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td>PUID</td>
    <td>1000 or name</td>
    <td><code>Optional</code>User Permission</td>
    <td>node</td>
    </tr>
    <tr>
    <td>PGID</td>
    <td>1000 or name</td>
    <td><code>Optional</code>Group Permission</td>
    <td>node</td>
    </tr>
    <tr>
    <td>WEB_PORT</td>
    <td>8080</td>
    <td><code>Optional</code>App web port</td>
    <td>8080</td>
    </tr>
    <tr>
    <td>WEB_NAME</td>
    <td>default</td>
    <td><code>Optional</code>App Name</td>
    <td>default</td>
    </tr>
    </tbody>
    </table>
