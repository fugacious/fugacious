![SemVer](https://img.shields.io/badge/version-v0.1.0-green.svg)
[![CircleCI](https://circleci.com/gh/fugacious/fugacious/tree/master.svg?style=svg)](https://circleci.com/gh/fugacious/fugacious/tree/master)
[![Dependency Status](https://gemnasium.com/fugacious/fugacious.svg)](https://gemnasium.com/fugacious/fugacious)
[![security](https://hakiri.io/github/fugacious/fugacious/master.svg)](https://hakiri.io/github/fugacious/fugacious/master)
[![Test Coverage](https://api.codeclimate.com/v1/badges/897245dd5fe511fd5333/test_coverage)](https://codeclimate.com/github/fugacious/fugacious/test_coverage)

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


### Getting started with development

#### Dependencies
- [Ruby 2](https://www.ruby-lang.org)
- [Redis](https://redis.io)
- [Qt](https://www.qt.io)

### [Docker](https://www.docker.com)

Be sure Docker is running, then

1. Build the environment with:
```
$ docker-compose build
```

2. Start the server
```
$ docker-compose up
```

That's it, the app is running on http://localhost:3000

### Local setup

1. Setup application dependencies
```
$ bin/setup
```

2. Start the app
```
$ foreman start
```

3. Open your browser to http://localhost:3000

#### User flows

We have an automated tool for generating user flows using real views generated from the application. These specs are excluded from our typical spec run because of the overhead of generating screenshots for each view.

The local instance of the application must be running in order to serve up the assets (eg. `foreman start`). Then, you can specify where the assets are hosted from and generate the views with:

```
$ RAILS_ASSET_HOST=localhost:3000 rake spec:user_flows
```

Then, visit http://localhost:3000/user_flows in your browser!

##### Exporting

The user flows tool also has an export feature which allows you to export everything for the web. You may host these assets with someting like [`simplehttpserver`](https://www.npmjs.com/package/simplehttpserver) or publish to [Federalist](https://federalist.18f.gov/). To publish user flows for Federalist, first make sure the application is running locally (eg. http://localhost:3000) and run:

```
$ RAILS_ASSET_HOST=localhost:3000 FEDERALIST_PATH=/site/user/repository rake spec:user_flows:web
```

This will output your site to `public/site/user/repository` for quick publishing to [Federalist](https://federalist-docs.18f.gov/pages/using-federalist/). To test compatibility, run `simplehttpserver` from the app's `public` folder and visit `http://localhost:8000/<FEDERALIST PATH>/user_flows` in your browser.

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -m 'Adds some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information

### Deploying to Heroku

##### Use this friendly button:
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/fugacious/fugacious)

##### Or, use our friendly bootstrap script:
Ensure you have the [Heroku Toolbelt](https://devcenter.heroku.com/articles/heroku-command-line) installed.

1. Execute Heroku setup with `bin/heroku`. Your shell output should look something [like this](https://gist.github.com/amoose/a955ec21a085ab087641044240314abb) and once successfully launched, will open your new Fugacious instance!

[Getting started with Rails 4 on Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails4) for more information.

### Operators

Fugacious URLs should be treated as sensitive information since knowing the URL
could allow someone to access the stored secret (assuming it was accessed
within the time-to-live of the secret). This means you should be careful about
how you configure your HTTP server. Many have a default configuration to log
all requests, including these sensitive URLs, to file or to stdout. Most PaaS,
like Heroku or Cloud Foundry are configured this way, too.

Operators of fugacious should take this into consideration when setting up
their app. Otherwise, they will potentially be disclosing sensitive information
to their hosting providers.


### License

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

For more information, see [license](https://github.com/fugacious/fugacious/blob/dev/LICENSE.md).
