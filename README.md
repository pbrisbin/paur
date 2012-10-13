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

#
# Omit the block to use default values (which are shown below)
#
Paur::Task.new do |t|

  t.aur_username = ENV['AUR_USERNAME']

  t.aur_password = ENV['AUR_PASSWORD']

  t.editor = ENV['EDITOR']

  t.exclude %w[ .git README.md LICENSE.txt ]

  t.pre_edit do
    #
    # ...
    #
  end

  t.post_edit do
    #
    # ...
    #
  end

end

task :default => :paur
~~~
