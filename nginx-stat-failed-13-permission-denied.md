# Nginx: stat() failed (13: permission denied)

from [https://stackoverflow.com/questions/25774999/nginx-stat-failed-13-permission-denied](https://stackoverflow.com/questions/25774999/nginx-stat-failed-13-permission-denied)

Nginx operates within the directory, so if you can't `cd` to that directory from the nginx user then it will fail (as does the `stat` command in your log). Make sure the `www-user` can `cd` all the way to the `/username/test/static`. You can confirm that the stat will fail or succeed by running

```sh
sudo -u www-data stat /username/test/static
```

In your case probably the `/username` directory is the issue here. Usually `www-data` does not have permissions to `cd` to other users home directories.

The best solution in that case would be to add www-data to username group:

```sh
gpasswd -a www-data username
```

and make sure that username group can enter all directories along the path:

```sh
chmod g+x /username && chmod g+x /username/test && chmod g+x /username/test/static
```

For your changes to work, restart nginx

```sh
nginx -s reload
```

## It's the solution for many **permission denied** errors
