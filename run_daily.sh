#!/bin/bash
# ExoCortex — C1 Daily Pipeline
# Запуск вечером: bash ~/exocortex/run_daily.sh

set -e

EXO_HOME="$HOME/exocortex"
DATE=$(date +%Y-%m-%d)
RAW_DIR="$EXO_HOME/raw"
REPORTS_DIR="$EXO_HOME/reports"
VENV_PYTHON=/home/ninjacat/.hermes/hermes-agent/venv/bin/python3
METRICS="$EXO_HOME/examples/metrics.jsonl"

mkdir -p "$RAW_DIR" "$REPORTS_DIR"
echo "=== ExoCortex C1: $DATE ==="

# 1. Запись голоса
echo "[1/4] Запись..."
REC_FILE="$RAW_DIR/$DATE.m4a"
if command -v arecord &>/dev/null; then
    arecord -f cd -t wav 2>/dev/null | ffmpeg -i - -c:a aac -b:a 64k "$REC_FILE" -y 2>/dev/null
    echo "Файл: $REC_FILE"
else
    echo "Нет arecord. Положи m4a в $RAW_DIR вручную."
fi

# 2. Транскрибация
echo "[2/4] GigaAM..."
if [ -f "$REC_FILE" ]; then
    $VENV_PYTHON -c "
import gigaam
print('Загрузка модели...')
model = gigaam.load_model('v3_ctc', device='cpu')
print('Транскрибация...')
text = model.transcribe_longform('$REC_FILE')
with open('$RAW_DIR/$DATE.txt', 'w') as f:
    f.write(text)
print(f'Распознано: {len(text.split())} слов')
"
else
    echo "Нет файла. Пропускаю."
fi

# 3. AI-анализ
echo "[3/4] DeepSeek..."
RAW_TEXT="$RAW_DIR/$DATE.txt"
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
YESTERDAY_REPORT="$REPORTS_DIR/$YESTERDAY.md"

if [ -f "$RAW_TEXT" ]; then
    REPORT=$(hermes chat -q "Ты — ExoCortex. Анализируй отчёт.

Философия: стоицизм, анти-лесть, спорь по умолчанию, сухие факты.

Сырой отчёт за $DATE:
$(cat "$RAW_TEXT")

$( [ -f "$YESTERDAY_REPORT" ] && echo "Вчерашний отчёт:" && cat "$YESTERDAY_REPORT" )

$( [ -f "$METRICS" ] && echo "Последние метрики:" && tail -7 "$METRICS" )

$( [ -f "$EXO_HOME/core/goals.md" ] && echo "Цели:" && cat "$EXO_HOME/core/goals.md" )

Заполни шаблон дневника:
- ⚡ Сигналы (что неочевидного)
- 📋 Директива (✅/❌)
- 📟 Панель датчиков (Сон, Энергия, GI, DQ, Exec Rate — 1-10)
- 🧠 Синтез (2-3 инсайта)
- 🧪 Гипотезы (макс 2, только новые)
- 🎯 Задачи на завтра (ONE ACTION + 3 результата)
- 📊 Одна строка JSONL метрик

На русском языке.")
    echo "$REPORT" > "$REPORTS_DIR/$DATE.md"
    echo "Отчёт сохранён"
else
    echo "Нет текста. Пропускаю."
fi

# 4. Коммит
echo "[4/4] Git..."
cd "$EXO_HOME"
git add -A 2>/dev/null
git commit -m "exo: daily C1 $DATE" 2>/dev/null || echo "Нет изменений"

echo "=== Готово: $DATE ==="
