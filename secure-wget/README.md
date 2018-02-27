# Secure WGET

This container is made to make is easy to download a file in a secure way.

## Examples

```bash
docker run --rm -v /tmp:/certs wget-secure sha256:25ddfa4ba7f2943a211bdf9b73fb41d3ab1b25d6e942669d3a6260e6f58602b3 /certs/download.tar.gz 'https://www.dropbox.com/s/certs.tar.gz?dl=1'
```

Output could be

```
Connecting to www.dropbox.com (162.125.13.37:443)
Connecting to dl.dropboxusercontent.com (162.125.13.37:443)
download.tar.gz      100% |*******************************|  4119   0:00:00 ETA

/certs/download.tar.gz: OK
```