#!/bin/bash
# Example: exo init — настройка ExoCortex под пользователя

echo "=== ExoCortex init ==="
echo ""

echo "Какие метрики трекать? (через запятую)"
echo "Пример: сон, энергия, стресс, деньги, спорт, настроение"
read -r METRICS

echo ""
echo "Нужна система целей 3/3/3?"
echo "1) Да"
echo "2) Только недельные"
echo "3) Нет (только журнал + паттерны)"
read -r GOALS

# Сохранить в config.json
# ...
