# Waste carriers acceptance tests

[![Build Status](https://travis-ci.com/DEFRA/waste-carriers-acceptance-tests.svg?branch=main)](https://travis-ci.com/DEFRA/waste-carriers-acceptance-tests)
[![security](https://hakiri.io/github/DEFRA/waste-carriers-acceptance-tests/main.svg)](https://hakiri.io/github/DEFRA/waste-carriers-acceptance-tests/main)

If your business carries waste in England then you need to register the activity with the Environment Agency.

This project contains the acceptance tests for the Waste Carriers digital service. It is built around [Quke](https://github.com/DEFRA/quke), a Ruby gem that simplifies the process of writing and running Cucumber acceptance tests.

## Pre-requisites

This project is setup to run against version 2.7.1 of Ruby. The rest of the pre-requisites are the same as those for [Quke](https://github.com/DEFRA/quke#pre-requisites).

Also some of the [rake](https://github.com/ruby/rake) tasks (to see the available list call `bundle exec rake -T`) and `config.yml` files assume you have the Waste Carriers [Vagrant](https://www.vagrantup.com/) environment running locally. Contact [Alan Cruikshanks](https://github.com/Cruikshanks) for details if unsure.

## Installation

First clone the repository and then drop into your new local repo

```bash
git clone https://github.com/DEFRA/waste-carriers-acceptance-tests.git && cd waste-carriers-acceptance-tests
```

Next download and install the dependencies

```bash
gem install bundler
bundle install
```

## Configuration

You can configure how the project runs using [Quke config files](https://github.com/DEFRA/quke#configuration).

Quke relies on .yaml files to configure how the tests are run in each environment.

You'll need to set the environment variable `WCRS_DEFAULT_PASSWORD` to the appropriate password to enable authentication into the apps.

If left as that by default when Quke is executed it will run against your selected environment using Chrome.

## Execution

To make it easy to switch between test environments, this repository has a config file for each environment in the `config` folder. You need to specify which config file to use when running a test.

To run a test in the `tst` environment, include an environment variable when calling Quke:

```bash
QUKE_CONFIG='config/tst.config.yml' bundle exec quke
```

To avoid having to type this out you can create an alias. For example, if you use `zsh` in Terminal on Mac, you can set this in your `.zshrc` file (a hidden file in your home directory) and restart Terminal for it to take effect:

```bash
alias tst="QUKE_CONFIG='config/tst.config.yml' bundle exec quke"

# then run full test suite with

tst
```

[More information on creating aliases](https://blog.lftechnology.com/command-line-productivity-with-zsh-aliases-28b7cebfdff9)

You can create [more config files](https://github.com/DEFRA/quke#multiple-configs), if needed, for example you may wish to have one setup for running against **Chrome**, and another to run against a different environment.

### Rake tasks

Within this project a series of [Rake](https://github.com/ruby/rake) tasks have been added. Each rake task is configured to run one of the configuration files already setup. To see the list of available commands run

```bash
bundle exec rake -T
```

You can then run your chosen configuration e.g. `bundle exec rake chrome64_osx`

### WCRS_DEFAULT_PASSWORD

You will also need to set the environment variable `WCRS_DEFAULT_PASSWORD` before running any tests. It is best practice not to include credentials within source code, so we have not included them in the `.config.yml` files attached to this project. However a number of the scenarios depend on being logged in, and therefore need to be able to access the password. Setting this environment variable is how they access it.

Add it to your `.zshrc` (open the file and add the line `export WCRS_DEFAULT_PASSWORD="mySuperStr0ngPassword"`). Then restart Terminal. You'll only have to do this once and then it'll be available always.

### VAGRANT_KEY_LOCATION

You will also need to set the environment variable `VAGRANT_KEY_LOCATION` to the path to your Vagrant environment private key location. This links to the rake task `reset` which a number of other rake tasks depend on.

Go to the root of the Waste Carriers vagrant project and then run the following

```bash
cd .vagrant/machines/default/virtualbox/
pwd
```

The final command should output a value like `/Users/myusername/wcr-vagrant/.vagrant/machines/default/virtualbox`. Add it to your `.zshrc` (open the file and add the line `export VAGRANT_KEY_LOCATION="/Users/myusername/wcr-vagrant/.vagrant/machines/default/virtualbox"`). You'll only have to do this once and then it'll be available always.

## Use of tags

[Cucumber](https://cucumber.io/) has an inbuilt feature called [tags](https://github.com/cucumber/cucumber/wiki/Tags).

These can be added to a [feature](https://github.com/cucumber/cucumber/wiki/Feature-Introduction) or individual **scenarios**.

```gherkin
@smoke
Feature: Validations within the digital service
```

```gherkin
@fo_old @happypath
Scenario: Registration by an individual
```

When applied you then have the ability to filter which tests will be used during any given run

As the test suite is quite large, tests are split into four main categories:

- `@fo` front office (external) dashboard, registrations and renewals
- `@bo` back office (internal) dashboard, finance, edits, renewals and more
- `@fo_old` front office registrations
- `@bo_old` back office dashboard and registrations

We are gradually moving functionality from "old" code to "new" code and the old functionality is gradually being deprecated.

Using a mix of tags you can both include and exclude tests to run:

```bash
tst --tags @fo_old # Run only things tagged with this
tst --tags @fo_old,@smoke # Run all things with these tags
tst --tags ~@fo_old # Don't run anything with this tag (run everything else)
```

### In this project

To have consistency across the project the following tags are defined and should be used in the following ways

|Tag|Description|
|---|---|
|@fo_old|Front office functionality in the older parts of the service|
|@fo|Front office functionality in the newer parts of the service|
|@bo_old|Back office functionality in the older parts of the service|
|@bo|Back office functionality in the newer parts of the service|
|@email|Indicates when an email is sent out during the scenario. Useful for testing emails or for omitting email tests when testing within corporate network|
|@broken|A scenario which is known to be broken due to the service not meeting expected behaviour|
|@ci|A feature that is intended to be run only on our continuous integration service (you should never need to use this tag).|
|@smoke| Tests where test data is created during the test, so no reliance on any data to run the tests. Useful for testing in hosted environments where we don't have a full set of seeded data|
|@minismoke| A light smoke test to quickly verify that all apps are working|
|Back office tags| @bo_renew, @bo_dashboard, @bo_finance, @bo_reg |
|Front office tags| @fo_renew, @fo_dashboard, @fo_reg |

It's also common practice to use a custom tag whilst working on a new feature or scenario e.g. `@focus` or `@wip`. That is perfectly acceptable but please ensure they are removed before your change is merged.

## Seeding data

Most Waste Carriers tests rely on data being created just before execution to provide the starting conditions ("Given") needed for a particular scenario. [More information on seeding](/features/seeds/README.md)

## Resetting data

In the local environment, data can be reset and re-seeded by running

```bash
bundle exec rake reset_dbs
```

In other environments, this can be done via the RESET_AND_SEED job in Jenkins.

While not needed for every test run, tests can sometimes fail due to clashing data in the environment. Data is automatically seeded from CBDU100 upwards (locally) and CBDU200 upwards (in all environments). However, if registration CBDU99 has been created by running tests, a second instance of CBDU100 will be created in the following test. This causes some tests to fail.

## Principles

- Keep feature files small, keeping it as close to "Given, When, Then" as reasonably possible. The steps should make it clear what the feature is actually testing. However, in some cases, smaller, repeatable steps make sense to allow re-use.
- Put the detailed functionality in a step, making use of helper functions to avoid duplication.
- Put shared page objects in the @journey app, where there is duplication between old/new apps, and front/back office.
- Use unique names for step and page files, even if they're in a different app.
- Reduce the number of files and apps where possible, unless it makes the tests hard to understand.

## Tips

In our experience one of the most complex and time consuming aspects of creating new features is identifying the right [CSS selector](http://www.w3schools.com/cssref/css_selectors.asp) to use, to pick the HTML element you need to work with.

A tool we have found useful is a Chrome addin called [SelectorGadget](http://selectorgadget.com/).

You can also test them using the Chrome developer tools. Open them up, select the elements tab and then `ctrl/cmd+f`. You should get an input field into which you can enter your selector and confirm/test its working. See <https://developers.google.com/web/updates/2015/05/search-dom-tree-by-css-selector>

Capybara has a known issue with links that don't have a valid href, as seen in MS dynamics. Work around is to find the element by ID and then call `click()` on it e.g. `page.find("#example-thing-id").click`. Issue details can be found here: <https://github.com/teamcapybara/capybara/issues/379>

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## Licence

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government licence v3

### About the licence

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
