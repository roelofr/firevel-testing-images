# [Firevel][1] testing images

This repository contains Docker images for GitHub Actions to test Google
services on.

It's made for Firevel, but should work on any repository requiring [gRPC][2]
and some PHP extensions.

## License

Licensed under [MIT][3].

## Supported versions

I'm closely sticking to the [PHP release schedule], which currently means the
following PHP versions are supported:

- `7.3`
- `7.4`
- `8.0`

If you want to stay on the most recent stable, you can also use the `latest`
branch, which matches the `latest` tag on the PHP Docker image.

Builts are scheduled to run weekly, on Saturday.

## Contents

The images will contain the most recent version of gRPC available on [PECL][4],
along with these extensions:

- bcmath
- curl
- dom
- mbstring
- zip

And, of course, a `composer` binary is present, running a recent Composer
release (Composer 2, at least).

## How to run

As this is a regular Docker image, you can run it using `docker run`, add it to a `docker-compose.yml` file or
add it as a `FROM` in your build files.

To use it in GitHub Actions you can use the `jobs.*.container` properties.
For example, to run simple unit tests in your project, you can use the following:

```yaml
jobs:
  my_job:
    container:
      image: ghcr.io/roelofr/php-grpc:latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: composer install --no-interaction --no-progress

      - name: Run tests
        run: vendor/bin/phpunit
```

[1]: https://github.com/firevel
[2]: https://grpc.io
[3]: ./LICENSE
[4]: https://www.php.net/supported-versions.php
