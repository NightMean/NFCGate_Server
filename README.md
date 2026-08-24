# NFCGate Server
This is the NFCGate server application using Python 3 and the Google [Protobuf](https://github.com/google/protobuf/) library, version 3.

To run, simply start the server using `python server.py`. You can then connect to the server using the IP address of your device and the default port of 5566.  
The server features a plugin system for data filtering. When starting the server, you can specify a list of plugins to be loaded as parameters, e.g. `python server.py log`. For an example, see the shipped `mod_log.py` plugin.

## Docker

The server can also run in Docker.

### Docker Compose (recommended)

Start the server with the shipped `log` plugin:

```sh
docker compose up -d
```

This builds the image and exposes port `5566` on the host. To change which plugins are loaded, edit the `command` entry in `docker-compose.yml`, e.g. `command: []` for no plugins.

### Plain Docker

Build and run manually:

```sh
docker build -t nfcgate-server .
docker run -d --name nfcgate-server -p 5566:5566 nfcgate-server log
```

Plugin names are appended after the image name, just like command line arguments of `server.py`.

### TLS in Docker

Mount your certificate and key into the container and pass the TLS options:

```sh
docker run -d --name nfcgate-server -p 5566:5566 \
  -v ./certs:/certs:ro \
  nfcgate-server log --tls --tls_cert /certs/cert.pem --tls_key /certs/key.pem
```

## Security

To achieve the lowest possible latency when relaying, the server application expects to be run in an isolated environment, where only authorized devices can connect.
That is why no authentication exists on the server side by default. DO NOT run the server on a public network or over the internet.
For confidentiality (not authentication!) use TLS via the `--tls_cert` and `--tls_key` options.

## Supported Setups

For the standard setup, we ran the server on a trusted laptop and connected both devices via WiFi AP to the laptop.
In order to minimize the latency between the devices, we have successfully connected two nearby devices via Bluetooth tethering or WiFi hotspot, hosting the server application via Termux on the hotspot device.
