#!/bin/bash
rm -rf .git
find . -type f -exec sed -i "s/FSharpTemplate/$1/g" {} +
find . -type f -exec bash -c "mv \$0 \${0/FSharpTemplate/$1}" {} \;