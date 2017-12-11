# apache2 webdav in docker with alpine linux

## example share conf

```apacheconf
Alias /testuser "/var/www/testuser/webdav"
<Directory "/var/www/testuser/webdav">
    Include /etc/apache2/webdav_defaults.conf
    AuthUserFile "/var/www/testuser/auth/users"
</Directory>
```
