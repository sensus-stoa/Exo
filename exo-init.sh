#!/bin/bash
# exo init — initial ExoCortex setup
# Run once after git clone

set -e

EXO_HOME="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$EXO_HOME/config.json"

echo "=== ExoCortex — Initial Setup ==="
echo ""

# 1. Metrics
echo "Which metrics do you want to track?"
echo "Comma-separated. Example: sleep, energy, stress, money, sport, mood"
echo "Enter — leave default (sleep, energy, GI, DQ)"
read -r METRICS_INPUT
if [ -z "$METRICS_INPUT" ]; then
    METRICS='["sleep","energy","GI","DQ"]'
else
    METRICS=$(echo "$METRICS_INPUT" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | awk '{print "\""$0"\""}' | paste -sd, | sed 's/^/[/;s/$/]/')
fi

echo ""
echo "Metrics: $(echo "$METRICS" | tr -d '[]' | tr ',' ' ')"

# 2. Goals
echo ""
echo "Do you need the 3/3/3 goals system?"
echo "  1) Yes (classic — Agile Results)"
echo "  2) Weekly only"
echo "  3) No (journal + patterns only)"
read -r GOALS_CHOICE

case "$GOALS_CHOICE" in
    2) GOALS_MODE="weekly" ;;
    3) GOALS_MODE="none" ;;
    *) GOALS_MODE="full" ;;
esac

# 3. Save config
cat > "$CONFIG_FILE" << EOF
{
  "version": 1,
  "metrics": $METRICS,
  "goals_mode": "$GOALS_MODE",
  "created": "$(date +%Y-%m-%d)"
}
EOF

echo ""
echo "Config saved: $CONFIG_FILE"
echo ""

# If no goals — clear goals.md
if [ "$GOALS_MODE" = "none" ]; then
    echo "# Goals disabled" > "$EXO_HOME/core/goals.md"
    echo "Goals disabled. goals.md cleared."
fi

echo "=== Done. Run C1 ==="
