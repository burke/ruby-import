$LOAD_PATH.unshift(__dir__)
require 'import'

module Foo
  MyClass = import('bar')
  puts MyClass.quux
end
