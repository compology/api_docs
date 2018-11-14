#! /bin/bash

echo "pandoc --reference-odt=$PWD/bin/api_template.odt $1 -o /tmp/$1.odt"
pandoc --reference-odt=$PWD/bin/api_template.odt $1 -o /tmp/$1.odt

