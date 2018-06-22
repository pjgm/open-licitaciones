# Open licitaciones

Open licitaciones is a project from Populate to create a usable UI and some services around the https://contrataciondelestado.es/

This is a work in progress.

## Requirements

- Ruby 2.5.1
- Rbenv or RVM
- Postgres >= 9.6
- ElasticSearch (optional)

## Setup

- Git clone the repository `git clone git@github.com:PopulateTools/open-licitaciones.git`
- Review `config/database.yml`. You need to setup `PG_USERNAME`, `PG_PASSWORD` and `PG_HOST` environment variables
- Run `bin/db_setup`
- Run `bin/import_feed` to load a few contracts

## Documentation

### Data model

The data model is very simple, it contains a single model: `Contract`.

Contract fields are (this is work in progress, this schema might change in the future):

| Field name             | Type            | Extra            | Description |
|------------------------|-----------------|------------------|-------------|
| id                     | String          | Primary key      | ID
| internal_id            | String          | Not null, Unique | UUID
| permalink              | String          | Not null, Unique | Permalink to access to the data
| entity_name            | String          | Not null         | Name of the entity the contractor belongs to
| contractor_name        | String          | Not null         | Name of the contractor
| status                 | String          | Not null         | Status of the contract (values:
| title                  | String          | Not null         | Object of the contract
| base_budget            | Float           |                  | Budgeted amount
| contract_value         | Float           |                  | Contract value
| contract_type          | String          |                  | Type of contract (services, work...)
| cpvs                   | Array of String |                  | List of CPVs
| cpvs_divisions         | Array of String |                  | List of first level CPVs
| cpvs_groups            | Array of String |                  | List of second level CPVs
| location               | String          |                  | Location (contains country name and sometimes province name and municipality name)
| hiring_procedure       | String          |                  | Type of hiring procedure
| date_proposal          | Date            |                  | Date of the proposal
| procedure_result       | String          |                  | Result of the prcedure
| assignee               | String          |                  | Assignee name
| number_of_proposals    | Integer         |                  | Number of proposals received
| final_amount           | Float           |                  | Final amount to pay
| updated_at             | DateTime        |                  | Timestamp when the contract info was updated
| publication_date       | Date            |                  | Date of publication
| municipality_id        | String          |                  | INE code of the municipality
| municipality_name      | String          |                  | Municpality name
| province_id            | String          |                  | INE code of the province
| province_name          | String          |                  | Province name
| autonomous_region_id   | String          |                  | INE code  of the autonomous region
| autonomous_region_name | String          |                  | Autonomous region name


### Workflow

There are two ([3 in the close future](https://github.com/PopulateTools/open-licitaciones/issues/1))
ways to import contracts in the database.

1 - Fetch latest published contracts from the recent contracts page. This is [ParseFeed](https://github.com/PopulateTools/open-licitaciones/blob/master/app/operations/parse_feed.rb) responsibility
2 - Fetch contracts history from [sitemap](https://contrataciondelestado.es/siteindex.xml). This is [ParseSitemap](https://github.com/PopulateTools/open-licitaciones/blob/master/app/operations/parse_sitemap.rb) responsibility
3 - Fetch the zip files with the history

These scripts follow a ELTL process because they **extract** and **load** the data. Afterwards, in `app/etl` there classes to **transform** the data and load it again.

Transformations are invoked from `bin/etl` scripts.

## How to contribute

To contribute you can:

- open an issue
- send a Pull Request following [Github standard flow](https://gist.github.com/Chaser324/ce0505fbed06b947d962)
- we'll review and accept it as soon as possible

## Licence

Software publicado bajo la licencia de código abierto AFFERO GPL v3 (ver [LICENSE-AGPLv3.txt](https://github.com/PopulateTools/open-licitaciones/blob/master/LICENSE-AGPLv3.txt))
