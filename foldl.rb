class Array
  def foldl(method)
    inject {|result, i| result.send(method, i) }
  end
end

arr = [1000.0, 200.0, 50.0]

arr << arr.foldl("/") 

p arr

# puts [1, 2, 3, 4].inject(0) { |result, element| result + element }