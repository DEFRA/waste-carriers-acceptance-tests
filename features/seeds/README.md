# Registration Data Seeding

This folder contains the required code that allows the acceptance tests suite to seed registrations using an ad-hoc API which is active in the back office.

The API endpoint accepts a JSON request format that contains a document object to load in the `registrations` collection inside mongoDB.

The API endpoint will cover:
- Generating and assigning a new `reg_identifier` number. The number will start with `CBDU` if the value of the `tier` is `upper`, or `CBDL` otherwise.
- Generating and assigning an `expires_on` date to the registration based on the back office ENV variable used in the normal flow.

The API will respond with a JSON format which contains the `reg_identifier` of the seeded entity so that it can be used in the test suite to perform operations on the seeded registration.

## Usage
An helper class called `SeedData` is part of the suite. It can be used in any step or helper method definition.

```
@reg_number = SeedData.seed("complete_active_registration.json")
```

The content of the seeded entity is saved in a JSON file stored in `features/seeds/fixtures/`.

To create a new entity to seed, for example an entity without payments, and hence still in progress, you can create a new file under `features/seeds/fixtures/` and use that file name as a parameter to `SeedData.seed`.

## Options

The `SeedData.seed` method will accept options parameters after the file name.
Each possible option is documented below

### Copy cards

This option will allow the generation of a registration containing an order with a dynamic number of copy cards.

#### Usage:

```
  SeedData.seed("outstanding_balance_pending_registration.json", copy_cards: 2)
```

#### What it does

The option will add a new copy cards order item to the first order of the finance details in the registration json
from the given document.
Balances will be authomatically re-calculated for the order and finance_details based on the number of copy cards
and then the registration will be seeded as normal.

NOTE: This will always create a registration with a balance different from 0, as the option *will not* generate a payment
for the extra copy cards item added to the order. There is the possibility to change this behaviour so that we can create
a payment for the copy cards order too, in case this become necessary / useful, contact a developer to implement it.


## Limitations

The seeding API only works for `registrations`, no `transient_registrations` support is available yet.
