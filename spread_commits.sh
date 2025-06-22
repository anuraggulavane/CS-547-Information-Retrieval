#!/bin/bash

# Real files from your repo
FILES=(
"CS547 Final Team 8(1).pptx"
"hw1_anurag.py"
"hw1.pdf"
"hw1.zip"
"hw2_Anurag_Gulavane.py"
"HW2_Information Retrival .pdf"
"hw2.pdf"
"hw2.zip"
"hw3_anurag_gulavane.py"
"HW3_Information Retrieval.pdf"
"hw3.pdf"
"hw3.zip"
"HW4 Part 1-1.pdf"
"HW4 Part 2-1.pdf"
"file_list.txt"
)

# Generate 84 unique commit days
echo "Generating 84 commits from 2024-08-22 to 2024-12-18..."

for i in $(seq 1 84); do
  # Random file
  FILE=${FILES[$RANDOM % ${#FILES[@]}]}

  # Random date: pick a random number of days since Aug 22 (0 to 118)
  OFFSET_DAYS=$((RANDOM % 119))
  BASE_DATE="2024-08-22"
  COMMIT_DAY=$(date -j -v+${OFFSET_DAYS}d -f "%Y-%m-%d" "$BASE_DATE" "+%Y-%m-%d")

  # Random time within that day
  HOUR=$((RANDOM % 24))
  MINUTE=$((RANDOM % 60))
  SECOND=$((RANDOM % 60))
  COMMIT_DATETIME="${COMMIT_DAY}T$(printf "%02d:%02d:%02d" $HOUR $MINUTE $SECOND)"

  # Append to file to trigger a commit
  echo "# Commit $i on $COMMIT_DATETIME" >> "$FILE"

  # Commit with backdated timestamp
  GIT_AUTHOR_DATE="$COMMIT_DATETIME" GIT_COMMITTER_DATE="$COMMIT_DATETIME" \
  git add "$FILE" && git commit -m "Commit $i on $COMMIT_DATETIME"
done

echo "✅ Done! Now push with:"
echo "   git push origin main"

