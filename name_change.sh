#!/bin/bash
find . -type f -exec sed -i "s/FSharpTemplate/$1/g" {} +
find . -type f -exec bash -c "mv \$0 \${0/FSharpTemplate/$1}" {} \;
rm name_change.sh
git remote remove origin
git add .
git commit -m "rename project to $1"