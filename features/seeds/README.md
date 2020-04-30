# Registration Data Seeding

This folder contains the required code that allows the acceptance tests suite to seed registrations using an ad-hoc API which is active in the back office.

The API endpoint accepts a JSON request format that contains a document object to load in the `registrations` collection inside mongoDB.

The API endpoint will cover:
- Generating and assigning a new `reg_identifier` number. The number will start with `CBDU` if the value of the `tier` is `upper`, or `CBDL` otherwise.
- Generating and assigning an `expires_on` date to the registration based on the back office ENV variable used in the normal flow.

The API will respond with a JSON format which contains the `reg_identifier` of the seeded entity so that it can be used in the test suite to perform operations on the seeded registration.

## Usage
An helper class called `SeedData` is part of the suite. It can be used in any step or helper method definition.

```ruby
@reg_number = SeedData.seed("limitedCompany_complete_active_registration.json")
```

The content of the seeded entity is saved in a JSON file stored in `features/seeds/fixtures/`.

To create a new entity to seed, for example an entity without payments, and hence still in progress, you can create a new file under `features/seeds/fixtures/` and use that file name as a parameter to `SeedData.seed`.

## Options

The `SeedData.seed` method will accept options parameters after the file name.
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
    "accountEmail" : "user@example.com",
    "declaredConvictions" : "no",
    "declaration" : "1",

    // ..... all  other data
}
```

Given that we want to create a registration using the above data but with a custom business name, we can use the options
like this:

```ruby
@reg_number = SeedData.seed("limitedCompany_complete_active_registration.json", "companyName" => "My new company name")
```

This will work for any attribute at the top level of the json document *as long as* the keys value matches
(in the example above, "companyName" matches the key value from the json content). It is case-sensitive.

** Warning **

This currently might give unwanted results if used with keys that have nested informations. For example, if you want to change
something in the "metaData" of a document, which has a nested piece of json, you can't use this option. Tweaks are possible
to make it work depending on what the necessities are. Just contact a developer :)

### Copy cards

This option will allow the generation of a registration containing an order with a dynamic number of copy cards.

#### Usage:

```ruby
  SeedData.seed("outstanding_balance_pending_registration.json", copy_cards: 2)
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
