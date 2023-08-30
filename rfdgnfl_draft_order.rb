# /Users/afxjzs/dev/projects/rfdgnfl_draft_order/rfdgnfl_draft_order.rb

require 'io/console'
require 'open3'
system("clear")
$stdout.sync = true

Thread.new do
  system('mpg123', '-q', './clock.mp3')
end
sleep 1

puts "
________   ________ ________      ____   ___      ___________ ____
`MMMMMMMb. `MMMMMMM `MMMMMMMb.   6MMMMb/ `MM\\     `M'`MMMMMMM `MM'
 MM    `Mb  MM    \\  MM    `Mb  8P    YM  MMM\\     M  MM    \\  MM
 MM     MM  MM       MM     MM 6M      Y  M\\MM\\    M  MM       MM
 MM     MM  MM   ,   MM     MM MM         M \\MM\\   M  MM   ,   MM
 MM    .M9  MMMMMM   MM     MM MM         M  \\MM\\  M  MMMMMM   MM
 MMMMMMM9'  MM   `   MM     MM MM     ___ M   \\MM\\ M  MM   `   MM
 MM  \\M\\    MM       MM     MM MM     `M' M    \\MM\\M  MM       MM
 MM   \\M\\   MM       MM     MM YM      M  M     \\MMM  MM       MM
 MM    \\M\\  MM       MM    .M9  8b    d9  M      \\MM  MM       MM    /
_MM_    \\M\\_MM_     _MMMMMMM9'   YMMMM9  _M_      \\M _MM_     _MMMMMMM
\n\n
"

puts "#{Time.now.year} Official Draft Order Selection\n\n"

draft_order = ["Doug", "James", "Whitney", "Ben", "Jared", "Oliver", "Nick", "Adam", "Justin", "Chris", "Anthony", "Carlton", "Alvi", "Randy"]
randomized_order = draft_order.shuffle

print "starting in "

3.downto(1) do |i|
  print "#{i}"
  3.times do
    print "."
    sleep 1
  end
end
print "\rGO!! 🚀                                \n\n"

pid = fork{ exec 'mpg123', '-q', './draft-music.mp3' }
sleep 1

spinner = Enumerator.new do |e|
  symbols = ['|', '/', '-', '\\']
  index = 0
  loop do
    e.yield symbols[index]
    index = (index + 1) % symbols.length
  end
end

randomized_order.each_with_index do |name, index|
  5.times do
    print "\rDraft Position #{index + 1}:\t#{spinner.next} Drafting..."
    sleep 0.5
  end
  print "\rDraft Position #{index + 1}:\t#{name}          \n"
  sleep 1
end

sleep 1
Process.kill("HUP", pid)
Process.wait(pid)

pid = fork{ exec 'mpg123', '-q', './complete.mp3' }

puts "\nCongrats, #{randomized_order.first}!! 🏆"

sleep 6

Process.kill("HUP", pid)
Process.wait(pid)
pid = fork{ exec 'mpg123', '-q', './womp-womp.mp3' }

puts "\n\nSorry #{randomized_order.last}. Womp, womp. 😭"

sleep 5

puts "\n\nThanks for watching! Tip your Commissioner!"

sleep 3

puts "\n\nSource code available at: https://github.com/afxjzs/rfdgnfl-draft-order"


Process.kill("HUP", pid)
Process.wait(pid)
system('killall -q mpg123')
sleep 30