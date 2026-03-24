# dbt-learn Project

Modern data transformation project using dbt with BigQuery.

## Project Structure
- `models/`: dbt models organized by staging and marts

## Schema Organization
- **Staging Schema**: Cleaned, standardized raw data (views)
- **Marts Schema**: Business-ready dimensional models (tables)
- **Default Schema**: Intermediate models (views)

## Environment Strategy
- **Development**: Isolated GCP project for safe experimentation
- **Production**: Separate GCP project for stable, validated data
Configure via `profiles.yml` with distinct targets for each environment.

## Usage
```bash
# Run all models
dbt run

# Test data quality
dbt test

# Build and test
dbt build
```

## Local GHA Testing

This will require creating `.sercrets` file that contains the environment variable `DBT_GCP_JSON_KEY_FILE` and `DBT_GCP_CI_JSON_KEY_FILE` as an inline value. To convert a JSON key fle to inline string use `cat <path-to-sa-key>.json | jq -c .`

Use `act` to test GitHub Actions workflows locally:
```bash
# Install act
brew install act

# Dry run
act workflow_dispatch --secret-file .secrets -n

# Execute
act workflow_dispatch --secret-file .secrets

# specific workflow
act --workflows .github/workflows/deploy.yml --secret-file .secrets
```

