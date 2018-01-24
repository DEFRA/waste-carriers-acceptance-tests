# Waste carriers acceptance tests

[![Build Status](https://travis-ci.org/DEFRA/waste-carriers-acceptance-tests.svg?branch=master)](https://travis-ci.org/DEFRA/waste-carriers-acceptance-tests)
[![security](https://hakiri.io/github/DEFRA/waste-carriers-acceptance-tests/master.svg)](https://hakiri.io/github/DEFRA/waste-carriers-acceptance-tests/master)
[![Dependency Status](https://dependencyci.com/github/DEFRA/waste-carriers-acceptance-tests/badge)](https://dependencyci.com/github/DEFRA/waste-carriers-acceptance-tests)

If your business carries waste then it could require a waste carriers licence

This project contains the acceptance tests for the Waste carriers digital service. It is built around [Quke](https://github.com/DEFRA/quke), a Ruby gem that simplifies the process of writing and running Cucumber acceptance tests.

## Pre-requisites

This project is setup to run against version 2.2.3 of Ruby.

The rest of the pre-requisites are the same as those for [Quke](https://github.com/DEFRA/quke#pre-requisites).

Also some of the [rake](https://github.com/ruby/rake) tasks (to see the available list call `bundle exec rake -T`) and `config.yml` files assume you have the Waste Carriers [Vagrant](https://www.vagrantup.com/) environment running locally. Contact [Alan Cruikshanks](https://github.com/Cruikshanks) or [Tim Stone](https://github.com/timstone) for details if unsure.

## Installation

First clone the repository and then drop into your new local repo

```bash
git clone https://github.com/DEFRA/waste-carriers-acceptance-tests.git && cd waste-carriers-acceptance-tests
```

Next download and install the dependencies

```bash
bundle install
```

## Configuration

You can figure how the project runs using [Quke config files](https://github.com/DEFRA/quke#configuration). Before executing this project for the first time you'll need to create an initial `.config.yml` file.

```bash
touch .config.yml
```

Into that file you'll need to add as a minimum this

```yaml
# Capybara will attempt to find an element for a period of time, rather than
# immediately failing because the element cannot be found. This defaults to 2
# seconds but with the need to confirm emails via mailinator, we have found we
# need to increase this time to at least 5 seconds
max_wait_time: 5

custom:
  accounts:
    agency_user:
      username: agency_user@example.gov.uk
      password: Password1234
    finance_admin:
      username: finance_admin@example.gov.uk
      password: Password1234
    finance_basic:
      username: finance_basic@example.gov.uk
      password: Password1234
    agency_user_with_payment_refund:
      username: agency_user_with_payment_refund@example.gov.uk
      password: Password1234
  urls:
    front_office: "http://domainundertest.gov.uk/registrations/start"
    front_office_sign_in: "http://domainundertest.gov.uk/users/sign_in?locale=en"
    back_office: "http://domainundertest.gov.uk/agency_users/sign_in"
    back_office_admin: "http://domainundertest.gov.uk/admins/sign_in"
    mail_checker: "https://www.mailinator.com"
```

If left as that by default when **Quke** is executed it will run against your selected environment using the headless browser **PhantomJS**. You can however override this and other values using the standard [Quke configuration options](https://github.com/DEFRA/quke#configuration).

### VAGRANT_KEY_LOCATION

You will also need to set the environment variable `VAGRANT_KEY_LOCATION` to the path to your Vagrant environment private key location. This links to the rake task `reset` which a number of other rake tasks depend on.

Go to the root of the Waste Carriers vagrant project and then run the following

```bash
cd .vagrant/machines/development/virtualbox/
pwd
```

The final command should output a value like `/Users/myusername/wcr-vagrant/.vagrant/machines/development/virtualbox`. Add it to your `~/.bash_profile` (open the file and add the line `export VAGRANT_KEY_LOCATION="/Users/myusername/wcr-vagrant/.vagrant/machines/development/virtualbox"`). You'll only have to do this once and then it'll be available always.

## Execution

To run all tests call

```bash
bundle exec quke
```

To run just the back or front office tests call

```bash
bundle exec quke --tags @frontoffice
bundle exec quke --tags @backoffice
```

You can create [multiple config files](https://github.com/DEFRA/quke#multiple-configs), for example you may wish to have one setup for running against **Chrome**, and another to run against a different environment. You can tell **Quke** which config file to use by adding an environment variable argument to the command.

```bash
QUKE_CONFIG='chrome.config.yml' bundle exec quke
```

## Use of tags

[Cucumber](https://cucumber.io/) has an inbuilt feature called [tags](https://github.com/cucumber/cucumber/wiki/Tags).

These can be added to a [feature](https://github.com/cucumber/cucumber/wiki/Feature-Introduction) or individual **scenarios**.

```gherkin
@functional
Feature: Validations within the digital service
```

```gherkin
@frontoffice @happypath
Scenario: Registration by an individual
```

When applied you then have the ability to filter which tests will be used during any given run

```bash
bundle exec quke --tags @frontoffice # Run only things tagged with this
bundle exec quke --tags @frontoffice,@happypath # Run all things with these tags
bundle exec quke --tags ~@functional # Don't run anything with this tag (run everything else)
```

### In this project

To have consistency across the project the following tags are defined and should be used in the following ways

|Tag|Description|
|---|---|
|@frontoffice|Any feature or scenario expected to be run against the front office application|
|@backoffice|Any feature or scenario expected to be run against the back office Dynamics application|
|@happypath|A scenario which details a complete registration with no errors|
|@functional|Any feature or scenario which is testing just a specific function of the service e.g. validation errors|
|@email|Indicates when an email is sent out during the scenario. Useful for testing emails or for omitting email tests when testing within corporate network|
|@broken|A scenario which is known to be broken due to the service not meeting expected behaviour|
|@ci|A feature that is intended to be run only on our continuous integration service (you should never need to use this tag).|

It's also common practice to use a custom tag whilst working on a new feature or scenario e.g. `@focus` or `@wip`. That is perfectly acceptable but please ensure they are removed before your change is merged.

## Tips

In our experience one of the most complex and time consuming aspects of creating new features is identifying the right [CSS selector](http://www.w3schools.com/cssref/css_selectors.asp) to use, to pick the HTML element you need to work with.

A tool we have found useful is a Chrome addin called [SelectorGadget](http://selectorgadget.com/).

You can also test them using the Chrome developer tools. Open them up, select the elements tab and then `ctrl/cmd+f`. You should get an input field into which you can enter your selector and confirm/test its working. See <https://developers.google.com/web/updates/2015/05/search-dom-tree-by-css-selector>

Capybara has a known issue with links that don't have a valid href, as seen in MS dynamics. Work around is to find the element by ID and then call `click()` on it e.g. `page.find("#example-thing-id").click`. Issue details can be found here: https://github.com/teamcapybara/capybara/issues/379

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
