#!/bin/bash
# exo init — первичная настройка ExoCortex
# Запустить один раз после git clone

set -e

EXO_HOME="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$EXO_HOME/config.json"

echo "=== ExoCortex — первичная настройка ==="
echo ""

# 1. Метрики
echo "Какие метрики ты хочешь трекать?"
echo "Через запятую. Пример: сон, энергия, стресс, деньги, спорт, настроение"
echo "Enter — оставить по умолчанию (сон, энергия, GI, DQ)"
read -r METRICS_INPUT
if [ -z "$METRICS_INPUT" ]; then
    METRICS='["сон","энергия","GI","DQ"]'
else
    METRICS=$(echo "$METRICS_INPUT" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | awk '{print "\""$0"\""}' | paste -sd, | sed 's/^/[/;s/$/]/')
fi

echo ""
echo "Метрики: $(echo "$METRICS" | tr -d '[]' | tr ',' ' ')"

# 2. Цели
echo ""
echo "Нужна система целей 3/3/3?"
echo "  1) Да (классическая — Agile Results)"
echo "  2) Только недельные"
echo "  3) Нет (только журнал + паттерны)"
read -r GOALS_CHOICE

case "$GOALS_CHOICE" in
    2) GOALS_MODE="weekly" ;;
    3) GOALS_MODE="none" ;;
    *) GOALS_MODE="full" ;;
esac

# 3. Сохраняем конфиг
cat > "$CONFIG_FILE" << EOF
{
  "version": 1,
  "metrics": $METRICS,
  "goals_mode": "$GOALS_MODE",
  "created": "$(date +%Y-%m-%d)"
}
EOF

echo ""
echo "Конфиг сохранён: $CONFIG_FILE"
echo ""

# Если целей нет — чистим goals.md
if [ "$GOALS_MODE" = "none" ]; then
    echo "# Цели отключены" > "$EXO_HOME/core/goals.md"
    echo "Цели отключены. goals.md очищен."
fi

echo "=== Готово. Запускай C1 ==="
