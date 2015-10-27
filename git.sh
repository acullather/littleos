#!/bin/bash
echo # littleos >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/acullather/littleos.git
git push -u origin master
