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

# All attributes have default values (shown below).
Paur::Task.new(:upload) do |t|
  t.aur_username = ENV['AUR_USERNAME']
  t.aur_password = ENV['AUR_PASSWORD']

  t.editor = ENV['EDITOR']

  # Use t.exclude to add to existing
  t.excludes = %w[ .git .gitignore README.md ]

  t.category = 16
end
~~~

Then type `rake upload`
