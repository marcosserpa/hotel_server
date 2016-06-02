### OBS: You need to have the gem *bundler* installed

# BASIC SETTINGS
## to install gems

```shell
bundle install
```


# TO RUN TESTS:
## to setup test database

```shell
rake db:migrate
rake db:test:prepare
```

## to execute the tests

```shell
rspec
```


# TO RUN THE APP:
# to setup the database

```shell
rake db:migrate
```

# to feed the app with 2 fictional hotels

```shell
rake db:seed
```

# to run the app in the rack default port (9292)

```shell
rackup
```

Then, now you can access the app in *localhost:9292*.