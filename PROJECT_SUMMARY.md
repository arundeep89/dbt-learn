# Project Summary

> This file was created with Gemini CLIApply .

This dbt project is named `jaffle_shop` and is configured to use the `my-bigquery-db` profile. It is a learning project to explore dbt features.

## Models

The project contains one model:

*   `customer`: This model creates a table with customer data. It includes tests to ensure that the `customer_id` is unique and not null.

## Macros

The project includes two macros:

*   `cents_to_dollars`: This macro converts a numeric column from cents to dollars.
*   `dev_limit_days_of_data`: This macro filters data to the last 3 days when the target is `default`.

## Packages

The project uses the following dbt packages:

*   `dbt-labs/dbt_utils`: A utility package for dbt.
*   `elementary-data/elementary`: A package for data monitoring.

## Requirements

The project requires the following Python packages:

*   `dbt-bigquery`
*   `dbt-core`
*   `elementary-data`
