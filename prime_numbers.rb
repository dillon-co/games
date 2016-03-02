class Number
  attr_accessor :number_list, :final_num, :primes_list
  def initialize(number)
    @final_num = number
    @number_list = number_list_init
    @primes_list = [2]
  end 

  def fix_number_2
    number_list[2] = false
  end  

  def number_list_init
    li = {}
    (2..@final_num).each { |num| li[num] = true }
    li
  end 
  
  def remove_non_primes(number)
    new_number = number
    until new_number >= @final_num
      new_number += number
      if number_list[new_number] == true 
        number_list[new_number] = false
      end  
    end 
  end

  def tick
    while @number_list.has_value?(true)
      t = Time.now
      remove_non_primes(@primes_list[-1])
      get_primes
      puts "number #{@primes_list[-1]} took #{Time.now - t} seconds"
    end  
  end  

  def get_primes
    @primes_list << number_list.key(true)
    number_list[number_list.key(true)] = false
  end 

  def draw
    fix_number_2
    tick
    puts "Primes upto #{final_num} are"
    @primes_list.each { |num| print "#{num}, "}
    puts ""
  end  
end  

puts "find primes up to which number?"
prime_input  = gets.chomp("> ").to_i

n = Number.new(prime_input)
puts " "
t = Time.now
puts n.draw
puts "\n\nthis took #{Time.now - t} seconds"


