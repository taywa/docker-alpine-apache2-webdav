# apache2 webdav in docker with alpine linux

## example vritualhost

```apacheconf
<VirtualHost *:80>
        ServerName localhost
        DocumentRoot /var/www/testuser/webdav

        <Location />
            #Options -Includes -ExecCGI -Indexes
            Include /etc/apache2/webdav_vhost.conf
            AuthUserFile "/var/www/testuser/auth/users"
        </Location>
</VirtualHost>
```