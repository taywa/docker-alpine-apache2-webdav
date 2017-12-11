# minimal apache2 webdav in docker with alpine linux

This image provides apache webdav serving with just 17MB (uncompressed).
It's build to be customizable and for multiple shares.

Each share is defined with an alias.

You can create a test container with the `test/docker-compose.yml` file.
Just checkout the code and run `docker-compose up` in the test folder.
After that you can connect to `http://localhost:8080/testuser` with
the user/pwd testuser/testuser.

## docker-compose.yml

Here is a example `docker-compose.yml` file to configure the service,
adapt it to your own settings. SSL is optional but almost mandatory for real world usage.

```
apache2:
  image: yvess/alpine-apache2-webdav:0.1
  hostname: apache2
  environment:
    - SERVER_NAME=myserver
    - CREATE_TESTUSER=YES
    - SSL=YES
    - SSL_KEY=/path_to_key/ssl.key
    - SSL_CERT=/path_to_cert/ssl.crt
    - WWW_DATA_UID=33 # optional
    - WWW_DATA_GID=33 # optional
  volumes:
    - /local_path_to_key/ssl.key:/path_to_key.key
    - /local_path_to_cert/ssl.crt:/path_to_cert.crt
    - ./davshares:/etc/apache2/davshares
    - /your_path/auth:/var/www/testuser_auth
    - /your_path/your_dir:/var/www/testuser_webdav
  ports:
    - "8443:443"
```

The `WWW_DATA_UID` and `WWW_DATA_GID` env vars are optional and set so that it matches the ubuntu default of
33 for the `www-data` user/group. You need to change this, to match the uid/gid for your share mounts,
otherwise the user `www-data` can't write into your share.

## example share conf

You can have multiple shares in the folder `davshares` (can be changed).

The share file `testuser.conf` in `davshares` looks like this.

```apacheconf
Alias /testuser "/var/www/testuser_webdav"
<Directory "/var/www/testuser_webdav">
    Include /etc/apache2/webdav_defaults.conf
    AuthUserFile "/var/www/testuser_auth/users"
</Directory>
```

Also mount the shares dir and auth files into the container.

```yaml
..
    - ./testuser_webdav:/var/www/testuser_webdav
    - ./testuser_auth:/var/www/testuser_auth
..
```

Inside or outside the container you you need to create htdigest password files with following command.
The realm is always webdav. Replace `password_file` `testuser` with your own settings.
(`users` is used for the `password_file` in the examples here).

```bash
htdigest -c password_file webdav testuser
```
