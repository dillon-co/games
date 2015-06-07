# @arr = [3, 5, 12, "Kittens"]

# @arr << @arr.clone

# @arr[4][4][4][4][4][4][4][4][4][4][4][4][4][0] = "CATS"

# puts @arr[0]


@box = Array.new(30, Array.new(30, " "))

middle = Array.new(10, " ")
left = Array.new(10, "[]")
right = Array.new(10, "[]")

@cave_arr = left + middle + right



@cave_arr.each_with_index { |x, ind| print "#{@cave_arr[ind]}" }

def draw_box
  system 'clear' or system 'cls'
  @box.each_with_index do |line, line_index|
    line.each_with_index do |row, row_index|
      print"#{@box[line_index][row_index]}"
    end 
    puts "" 
  end  
end  

def update_box  
  @box.unshift(@cave_arr)
  @box.pop
end

def play
  while true
    update_box
    draw_box
    sleep 0.04
  end  
end

puts play   