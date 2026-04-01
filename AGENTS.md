# AGENTS.md

This is a sample dbt project using MetricFlow for creating metrics.


## Dev Environment Setup

### Install dependencies

`uv sync` creates the `.venv` virtual environment automatically on first run and reuses it on subsequent runs.

```bash
uv sync
```

### Activate the virtual environment

```bash
source .venv/bin/activate       # macOS/Linux
# .venv\Scripts\activate        # Windows
```

All subsequent `dbt` commands must be run inside this activated environment.

---

## Project Structure

```
models/thelook_ecommerce/
├── staging/                    # Views; clean and rename raw source columns
├── marts/                      # Tables; business-ready joins and aggregations
├── semantic_models/            # MetricFlow semantic model YAML definitions
├── metrics/                    # MetricFlow metric definitions
├── metricflow_time_spine.sql   # Required date spine for MetricFlow time-series queries
├── _models.yml                 # time_spine model config
└── _groups.yml                 # Access group definitions (sales, ecommerce)
```

---

## Coding Style

### Model naming

| Prefix | Layer | Location |
|--------|-------|----------|
| `stg_` | Staging | `models/thelook_ecommerce/staging/` |
| `dim_` | Dimension mart | `models/thelook_ecommerce/marts/` |
| `fact_` | Fact mart | `models/thelook_ecommerce/marts/` |
| `sem_` | Semantic models| `models/thelook_ecommerce/semantic_models/` |

- Reference other models with `{{ ref('model_name') }}`
- Reference raw sources with `{{ source('thelook_ecommerce', 'table_name') }}`

Do not modify `generate_custom_schema.sql`.
