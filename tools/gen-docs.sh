#!/bin/sh

# Requires that yuidocjs is installed
# npm install -g yuidocjs

# The location of the files to parse.  Parses subdirectories, but will fail if
# there are duplicate file names in these directories.  You can specify multiple
# source trees:
#     parser_in="%HOME/www/yui/src %HOME/www/event/src"
parser_in="lib test"

# The location of the template files.  Any subdirectories here will be copied
# verbatim to the destination directory.
template=./doc/template

# The version of your project to display within the documentation.
version=`grep version package.json | sed 's/.*: "\(.*\)".*/\1/'`

##############################################################################
# add -s to the end of the line to show items marked private

#rm doc/*.html
yuidoc \
  $parser_in \
  -c "../yuidoc.json" \
  -o $generator_out \
  -v $version


#echo Copying the documentation to ../tomkoufakis.github.com/app-config/$version
#rm -rf ../tomkoufakis.github.com/app-config/$version
#cp -R doc ../tomkoufakis.github.com/app-config/$version
#echo Copying the documentation to ../tomkoufakis.github.com/app-config/latest
#rm -rf ../tomkoufakis.github.com/app-config/latest
#cp -R doc ../tomkoufakis.github.com/app-config/latest
