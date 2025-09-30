> [!NOTE]
> All of my GitHub repositories have been **archived** and will be migrated to
> Codeberg as I next work on them. This repository either now lives, or will
> live, at:
>
> https://codeberg.org/pbrisbin/paur
>
> If you need to report an Issue or raise a PR, and this migration hasn't
> happened yet, send an email to me@pbrisbin.com.

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
