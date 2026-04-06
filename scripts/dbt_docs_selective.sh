set -euo pipefail

echo "===> Selective dbt docs generate (partial catalog)…"

MODELS=()

# Loop through files passed by pre-commit
for file in "$@"; do
  ext="${file##*.}"

  # Extract model name from SQL files
  if [[ "$ext" == "sql" ]]; then
    model=$(basename "$file" .sql)
    MODELS+=("$model")
  fi

  # Extract model names from YAML files by parsing the file
  if [[ "$ext" == "yml" || "$ext" == "yaml" ]]; then
    # Extract model names from 'name:' field in YAML under 'models:' section
    # Only match at the models level (2 spaces indentation), not columns
    if [ -f "$file" ]; then
      in_models_section=false
      while IFS= read -r line; do
        # Check if we're in models section
        if [[ "$line" =~ ^models: ]]; then
          in_models_section=true
          continue
        fi
        # Match model name with exactly 2 spaces indent (under models:)
        if [[ "$in_models_section" == true ]] && [[ "$line" =~ ^[[:space:]]{2}-[[:space:]]+name:[[:space:]]+([a-zA-Z0-9_]+) ]]; then
          model_name="${BASH_REMATCH[1]}"
          MODELS+=("$model_name")
        fi
        # Stop if we encounter a non-indented line or columns section
        if [[ "$in_models_section" == true ]] && [[ "$line" =~ ^[a-zA-Z] ]] && [[ ! "$line" =~ ^models: ]]; then
          in_models_section=false
        fi
      done < "$file"
    fi
  fi
done

# Remove duplicates
MODELS=($(printf "%s\n" "${MODELS[@]}" | sort -u))

if [ ${#MODELS[@]} -eq 0 ]; then
  echo "No SQL/YAML dbt models detected — skipping docs generation."
  exit 0
fi

echo "Models to generate catalog for:"
printf ' - %s\n' "${MODELS[@]}"

# Build the --select string for dbt
# Use each model name directly without + to avoid including dependencies
SELECT_ARGS="${MODELS[*]}"

echo "Running: dbt docs generate --select $SELECT_ARGS"
dbt docs generate --select $SELECT_ARGS