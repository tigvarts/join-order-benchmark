echo "Downloading data..."
wget -O /tmp/imdb.tgz http://homepages.cwi.nl/~boncz/job/imdb.tgz

echo "Unpacking data..."
mkdir -p /tmp/imdb_csv
tar -zxvf /tmp/imdb.tgz -C /tmp/imdb_csv

echo "Processing data..."
for i in /tmp/imdb_csv/*; do echo "Converting $i..." && python convert.py $i; done

echo "Making database..."
psql -d postgres -c "drop database if exists join_order_benchmark"
psql -d postgres -c "create database join_order_benchmark"
psql -d join_order_benchmark < schema.sql
psql -d join_order_benchmark < imdb_load.sql
psql -d join_order_benchmark < fkindexes.sql
psql -d join_order_benchmark < imdb_analyse.sql
rm -rf /tmp/imdb_csv
rm /tmp/imdb.tgz
echo "Database made successfully."
