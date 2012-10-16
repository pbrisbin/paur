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

### Configuration

The task name is passed to the initializer with all other aspects being 
controlled via the block.

Defaults values shown below.

~~~ { .ruby }
Paur::Task.new(:upload) do |t|
  t.aur_username = ENV['AUR_USERNAME']
  t.aur_password = ENV['AUR_PASSWORD']

  t.editor = ENV['EDITOR']

  # Use t.exclude to add to existing setting
  t.excludes = %w[ .git .gitignore README.md ]

  t.category = 16 # System
end
~~~
