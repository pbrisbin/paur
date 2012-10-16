# Paur

Paur POSTs packages to the AUR.

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
#
# Rakefile
#
require 'paur/task'

Paur::Task.new
~~~

Then, `rake upload`.

### Caveats

Currently the final step errors saying the form token is invalid, I'm 
still debugging this.
