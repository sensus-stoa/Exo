#!/bin/bash
# ExoCortex — C1 Daily Pipeline
# Run in the evening: bash ~/exocortex/run_daily.sh

set -e

EXO_HOME="$HOME/exocortex"
DATE=$(date +%Y-%m-%d)
RAW_DIR="$EXO_HOME/raw"
REPORTS_DIR="$EXO_HOME/reports"
METRICS="$EXO_HOME/examples/metrics.jsonl"

mkdir -p "$RAW_DIR" "$REPORTS_DIR"
echo "=== ExoCortex C1: $DATE ==="

# 1. Voice recording
echo "[1/4] Recording..."
REC_FILE="$RAW_DIR/$DATE.m4a"
if command -v arecord &>/dev/null; then
    arecord -f cd -t wav 2>/dev/null | ffmpeg -i - -c:a aac -b:a 64k "$REC_FILE" -y 2>/dev/null
    echo "File: $REC_FILE"
else
    echo "No arecord. Place m4a in $RAW_DIR manually."
fi

# 2. Transcription
echo "[2/4] GigaAM..."
if [ -f "$REC_FILE" ]; then
    python3 -c "
import gigaam
print('Loading model...')
model = gigaam.load_model('v3_ctc', device='cpu')
print('Transcribing...')
text = model.transcribe_longform('$REC_FILE')
with open('$RAW_DIR/$DATE.txt', 'w') as f:
    f.write(text)
print(f'Recognized: {len(text.split())} words')
"
else
    echo "No file. Skipping."
fi

# 3. AI analysis
echo "[3/4] AI analysis..."
RAW_TEXT="$RAW_DIR/$DATE.txt"
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
YESTERDAY_REPORT="$REPORTS_DIR/$YESTERDAY.md"

if [ -f "$RAW_TEXT" ]; then
    # Replace with your AI call: DeepSeek API, Claude, local LLM, etc.
    # Example using a generic AI CLI:
    # REPORT=$(ai-agent analyze --prompt "...")
    echo "AI analysis step — configure your AI agent call here."
    echo "Raw text saved to: $RAW_TEXT"
else
    echo "No text. Skipping."
fi

# 4. Commit
echo "[4/4] Git..."
cd "$EXO_HOME"
git add -A 2>/dev/null
git commit -m "exo: daily C1 $DATE" 2>/dev/null || echo "No changes"

echo "=== Done: $DATE ==="
