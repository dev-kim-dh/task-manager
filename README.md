## Command

#### crontab 최신화 커맨드

```sh
$ whenever --update-crontab
```

#### DB migration실행

```sh
$ bundle exec rake ridgepole:apply
```

#### Sidekiq실행

```sh
$ bundle exec sidekiq -C config/sidekiq.yml
```

#### crontab실행/정지

```sh
$ service cron start
$ service cron stop
```
