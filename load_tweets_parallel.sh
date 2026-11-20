#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
time parallel ./load_denormalized.sh ::: $files

echo '================================================================================'
echo 'load pg_normalized'
time parallel python3 -u load_tweets.py --db=postgresql+psycopg2://postgres:pass@localhost:1135/ --inputs {} ::: $files

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time parallel python3 -u load_tweets_batch.py --db=postgresql+psycopg2://postgres:pass@localhost:12000/ --inputs {} ::: $files
