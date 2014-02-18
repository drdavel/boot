#!/bin/bash

# install brew package manager
echo "Installing brew package manager"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# install pip python package manager
echo "Installing pip package manager"
curl -fsSL https://raw.github.com/pypa/pip/master/contrib/get-pip.py --output get-pip.py
sudo python get-pip.py

# installing brew formulae
for pkg in `cat brew-formulae` ; do
    brew install $pkg
done

# create python virtual envs
for venv in `ls requirements-*.txt | perl -p -e 's/.*-(\w+)\.txt/$1/;'` ; do
    pyenv virtualenv $venv
done

# install packages needed in each virtual env
for venv in `ls requirements-*.txt | perl -p -e 's/.*-(\w+)\.txt/$1/;'` ; do
    pyenv activate $venv
    pip install -r requirements-$venv.txt
    pyenv deactivate $venv
done
