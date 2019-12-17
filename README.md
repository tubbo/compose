# compose

A helper function for using [docker-compose][] and [docker stack][] in
multiple environments.

`compose` is useful for projects that span Docker configuration across
multiple `docker-compose.yml` files for setting up different services in
different environments (for example, running a cache server in
production and running headless chrome for testing).

## Usage

By default, your environment is assumed to be `development`. This
command will run using the `docker-compose.development.yml` file:

```bash
$ compose run --rm -it web rails --tasks
```

Prepending the name of your environment can change that for a single
command:

```bash
$ compose test run --rm -it web rails test
```

In addition, you can persist a custom environment by setting
`$COMPOSE_ENV`:

```bash
$ export COMPOSE_ENV=production
$ compose up -d
```

All commands are passed through to `docker-compose`, which are given the
`-f` arguments to choose which file(s) to use.

### Docker Stacks

A special `deploy` pseudo-environment can always be invoked to instead
run your commands using `docker stack`:

```bash
$ compose stack deploy
```

Unlike the other commands, `compose stack` defaults to using
`docker-compose.production.yml` in addition to `docker-compose.yml` for
setting up your services.

## Installation

[Download the latest release][] and extract the tarball, then run the
following command from the directory created during extraction:

```bash
$ sudo make install
```

This will install the `compose` script to `/usr/local/bin`. You can
change this by prepending `PREFIX=/some/custom/location`.

## Development

To release a new version, update the `VERSION` var in Make, then run:

```bash
$ make release
```

[docker-compose]: https://docs.docker.com/compose/
[docker stack]: https://docs.docker.com/engine/reference/commandline/stack/
[Download the latest release]: https://github.com/tubbo/compose/releases
