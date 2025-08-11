# Registration Data Seeding

This folder contains the required code that allows the acceptance tests suite to seed registrations using an ad-hoc API which is active in the back office.

The API endpoint accepts a JSON request format that contains a document object to load in the `registrations` collection inside mongoDB.

The API endpoint will cover:

- Generating and assigning a new `reg_identifier` number. The number will start with `CBDU` if the value of the `tier` is `upper`, or `CBDL` otherwise.
- Generating and assigning an `expires_on` date to the registration based on the back office ENV variable used in the normal flow, equal to the value of the `WCRS_REGISTRATION_EXPIRES_AFTER`. This is unless [custom_expire](custom_expire) is set.

The API will respond with a JSON format which contains the `reg_identifier` of the seeded entity so that it can be used in the test suite to perform operations on the seeded registration.

## Usage

A helper class called `SeedData` is part of the suite. It can be used in any step or helper method definition.

```ruby
seed_data = SeedData.new("limitedCompany_complete_active_registration.json")
@reg_number = seed_data.reg_number
@seeded_data = seed_data.seeded_data
```

The content of the seeded entity is saved in a JSON file stored in `features/seeds/fixtures/`.

To create a new entity to seed, for example an entity without payments, and hence still in progress, you can create a new file under `features/seeds/fixtures/` and use that file name as a parameter to `SeedData.new`.

When creating a new file, the data will be the same format as in the local database, except you need to do the following:

- remove any `_id` fields
- remove the `regIdentifier`
- remove `ISODate(` and `)` from any dates

## Options

The `SeedData.new` method will accept options parameters after the file name.
Each possible option is documented below

### Setting any top level attribute

The options can be used to do small tweaks to the data in the registration we want to seed.

For example, if we want to have control over the company name of a registration we are seeding, we can
pass a new business name to the seeding via options. This is demonstrated below.

The content of the `limitedCompany_complete_active_registration.json` file looks like:

```json
{
    "tier" : "UPPER",
    "registrationType" : "carrier_dealer",
    "businessType" : "limitedCompany",
    "otherBusinesses" : "no",
    "constructionWaste" : "yes",
    "companyName" : "UT Company limited", // this is the company name we want to change
    "firstName" : "Bob",
    "lastName" : "Carolgees",
    "phoneNumber" : "0117 4960000",
    "contactEmail" : "user@example.com",
    "declaredConvictions" : "no",
    "declaration" : "1",

    // ..... all  other data
}
```

Given that we want to create a registration using the above data but with a custom business name, we can use the options
like this:

```ruby
seed_data = SeedData.new("limitedCompany_complete_active_registration.json", "companyName" => "My new company name")
```

This will work for any attribute at the top level of the json document *as long as* the keys value matches
(in the example above, "companyName" matches the key value from the json content). It is case-sensitive.

Warning

This currently might give unwanted results if used with keys that have nested informations. For example, if you want to change
something in the "metaData" of a document, which has a nested piece of json, you can't use this option. Tweaks are possible
to make it work depending on what the necessities are. Just contact a developer :)

### Custom expires_on date

Registrations are automatically set an `expires_on` date by the back-office seed API if one is not already set in the data it receives.

This is based on the current date plus the config used in its environment. With a standard config this would be the current date plus 3 years.

To set the `expire_on` date ensure your `features/seeds/fixtures/my_seed.json` file contains an `expires_on` entry. For example

```json
    "declaration" : "1",
    "expires_on" : "2020-05-14T10:38:17.311Z",
```

That's it! If you wish to use a dynamic date for your `expires_on` (which is advised to avoid 'brittle tests') you can make use of the [Setting any top level attribute](#setting-any-top-level-attribute) to override the one set in the fixture.

```ruby
  days_ago = 30
  expiry_date = (DateTime.now - days_ago)
  seed_data = SeedData.new("limitedCompany_expired_registration.json", "expires_on" => expiry_date.to_s)
```

### Copy cards

This option will allow the generation of a registration containing an order with a dynamic number of copy cards.

#### Example usage

```ruby
  SeedData.new("outstanding_balance_pending_registration.json", copy_cards: 2)
```

#### What it does

The option will add a new copy cards order item to the first order of the finance details in the registration json
from the given document.
Balances will be automatically re-calculated for the order and finance_details based on the number of copy cards
and then the registration will be seeded as normal.

NOTE: This will always create a registration with a balance different from 0, as the option *will not* generate a payment
for the extra copy cards item added to the order. There is the possibility to change this behaviour so that we can create
a payment for the copy cards order too, in case this become necessary / useful, contact a developer to implement it.

## Limitations

The seeding API only works for `registrations`, no `transient_registrations` support is available yet.

## Running on CI environments

As seeding of data is run outside of the quke test runner it doesn't pick up the proxy used in the quke configuration,
to get around this the environment variable `WCRS_PROXY` is used to control whether to use a proxy to seed data.
