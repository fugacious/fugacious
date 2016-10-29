![SemVer](https://img.shields.io/badge/version-v0.1.0-green.svg)
[![Dependency Status](https://gemnasium.com/fugacious/fugacious.svg)](https://gemnasium.com/fugacious/fugacious)
[![Security](https://hakiri.io/github/fugacious/fugacious/dev.svg)](https://hakiri.io/github/fugacious/fugacious/dev)
[![Build Status](https://travis-ci.org/fugacious/fugacious.svg?branch=dev)](https://travis-ci.org/fugacious/fugacious)
[![Coverage Status](https://coveralls.io/repos/github/fugacious/fugacious/badge.svg?branch=dev)](https://coveralls.io/github/fugacious/fugacious?branch=dev)

![Fugacious](https://raw.githubusercontent.com/fugacious/fugacious/dev/app/assets/images/logo-small.png)
##### open source short-term secure messaging solution
&nbsp;
* * *

### How it works

Need to send a secret to someone? Use Fugacious to ensure that no permanent record of your secret will remain. 

1. Visit [fugacio.us](https://fugacio.us)
2. Enter your secret
3. Share your link 

The link to your secret will only remain alive for the preset amount of time or number of views.


### Getting Started

#### Dependencies
- [Ruby 2](https://www.ruby-lang.org)
- [Redis](https://redis.io)
- [QT](https://www.qt.io)

1. Setup application dependencies
  ```
  $ bin/setup
  ```
2. Start the app
  ```
  $ foreman start
  ```
3. Open your browser to http://localhost:3000


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -m 'Adds some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information


### License

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

For more information, see [license](https://github.com/fugacious/fugacious/blob/dev/LICENSE.md).
