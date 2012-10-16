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

Run paur from within a directory containing a PKGBUILD (and any 
to-be-included source files). Category defaults to "system".

~~~
Usage: paur [options]
    -c, --category CATEGORY
    -v, --verbose
~~~

Paur also provides a Rake task:

~~~ { .ruby }
#
# Rakefile
#
require 'paur/task'

Paur::Task.new do |t|
  t.category = 'system'
end
~~~

Then type `rake upload`.

### Caveats

Currently the final step errors saying the form token is invalid, I'm 
still debugging this.

The process leaves both the `src` directory and generated taurball 
present after it completes. I haven't decided yet how to automate that 
cleanup.
