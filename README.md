Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

## Notes for local test using ~/.dbt/profiles.yml:
- dbt run --profile dbt_warehouse --select customer
- enable billing in GCP project
- dbt run --profile dbt_warehouse  --select elementary
- dbt run-operation elementary.generate_elementary_cli_profile

## Error
Ran into same error as stated [here](https://github.com/elementary-data/elementary/issues/1679)