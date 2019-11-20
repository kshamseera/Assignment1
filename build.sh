#!/bin/sh

# make a distribution directory
mkdir -p dist

# copy Ruby files to the distribution directory
cp ./main.rb ./dist
cp ./appointment-class.rb ./dist
cp ./methods.rb ./dist


# install required gems
gem install colorize
gem install tty-prompt
gem install tty-font
gem install pastel
