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

Add the following to a `Rakefile` within your project directory:

~~~ { .ruby }
require 'paur/task'

Paur::Task.new
~~~

Then type `rake upload`.

### Caveats

It doesn't upload yet, just builds the Taurball
