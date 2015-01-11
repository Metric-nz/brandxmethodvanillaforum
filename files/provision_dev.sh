#!/usr/bin/env bash

for f in /etc/php5/cli/php.ini /etc/php5/apache2/php.ini
do
  sed -i "s/;date.timezone =/date.timezone = Europe\/Paris/" $f
  echo "xdebug.max_nesting_level=250" >> $f
done  