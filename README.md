# Paur

Paur POSTs packages to the AUR.

## Details

1. Does `makepkg --geninteg` into your PKGBUILD
2. Presents the PKGBUILD for final editing
3. Does `makepkg --source` to generate a taurball
4. Uploads that taurball to the AUR

Note: `makepkg --clean` is used to remove working files.

## Installation

~~~
$ git clone https://github.com/pbrisbin/paur
$ cd paur
$ bundle
$ rake install
~~~

## Usage

Export the `AUR_USERNAME` and `AUR_PASSWORD` environment variables.

~~~
Usage: paur [options]
    -c, --category CATEGORY
    -v, --verbose
~~~

## Rake

~~~ { .ruby }
# Rakefile
require 'paur/task'

Paur::Task.new
~~~

Then, `rake upload`.
