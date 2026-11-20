#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    sh load_denormalized.sh "$file"
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    echo
    python3 -u load_tweets.py --db=postgresql+psycopg2://postgres:pass@localhost:1135/ --inputs "$file"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql+psycopg2://postgres:pass@localhost:12000/ --inputs $file
done
