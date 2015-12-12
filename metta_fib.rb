#!/env/ruby

# INDEX: 0 1 2 3 4 5 6 7  8  ... 50
# FIB:   0 1 1 2 3 5 8 13 21 ... 12586269025

module Memoization
  def memoize(method_name)
    @@ha = Hash.new { |h, k| h[k] = {} }
    original_method = instance_method(method_name) # unbound method object(not connected to original class)
    define_method(method_name) do |args| #creates or redefines method
      @@ha[method_name][args] ||= original_method.bind(self).call(args)
      ### .bind binds the method back to a class, .call calls the method
    end
  end
end


class Fib
  extend Memoization

  def index(num)
    num < 2 ? num : index(num-1)+index(num-2)
  end
  memoize :index
end

fib = Fib.new

p fib.index(0) == 0
p fib.index(1) == 1
p fib.index(2) == 1
p fib.index(3) == 2
p fib.index(8) == 21
t = Time.now
p fib.index(20)
p Time.now - t