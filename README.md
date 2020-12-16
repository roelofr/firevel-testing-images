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

[1]: https://github.com/firevel
[2]: https://grpc.io
[3]: ./LICENSE
[4]: https://www.php.net/supported-versions.php
