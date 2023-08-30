# This is the main script for the Draft Order Generator
# /Users/afxjzs/dev/projects/rfdgnfl_draft_order/rfdgnfl_draft_order.rb

# Require necessary libraries
require 'io/console'
require 'open3'

# Clear the console for a clean start
system("clear")

# Ensure that the output is flushed immediately to the console
$stdout.sync = true

# Start a new thread to play the clock sound
Thread.new do
  system('mpg123', '-q', './clock.mp3')
end

# Pause execution for 1 second
sleep 1

# Print the ASCII art and introduction message
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

# Print the current year and the title of the event
puts "#{Time.now.year} Official Draft Order Selection\n\n"

# Define the draft order
draft_order = ["Doug", "James", "Whitney", "Ben", "Jared", "Oliver", "Nick", "Adam", "Justin", "Chris", "Anthony", "Carlton", "Alvi", "Randy"]

# Randomize the draft order
randomized_order = draft_order.shuffle

# Print the starting message
print "starting in "

# Countdown from 3 to 1
3.downto(1) do |i|
  print "#{i}"
  3.times do
    print "."
    sleep 1
  end
end

# Print the go message
print "\rGO!! 🚀                                \n\n"

# Start a new process to play the draft music
pid = fork{ exec 'mpg123', '-q', './draft-music.mp3' }
sleep 1

# Create a spinner for the drafting animation
spinner = Enumerator.new do |e|
  symbols = ['|', '/', '-', '\\']
  index = 0
  loop do
    e.yield symbols[index]
    index = (index + 1) % symbols.length
  end
end

# Print the draft order with animation
randomized_order.each_with_index do |name, index|
  5.times do
    print "\rDraft Position #{index + 1}:\t#{spinner.next} Drafting..."
    sleep 0.5
  end
  print "\rDraft Position #{index + 1}:\t#{name}          \n"
  sleep 1
end

# Pause execution for 1 second
sleep 1

# Kill the music process
Process.kill("HUP", pid)
Process.wait(pid)

# Start a new process to play the completion sound
pid = fork{ exec 'mpg123', '-q', './complete.mp3' }

# Print the winner message
puts "\nCongrats, #{randomized_order.first}!! 🏆"

# Pause execution for 6 seconds
sleep 6

# Kill the completion sound process
Process.kill("HUP", pid)
Process.wait(pid)

# Start a new process to play the sad trombone sound
pid = fork{ exec 'mpg123', '-q', './womp-womp.mp3' }

# Print the loser message
puts "\n\nSorry #{randomized_order.last}. Womp, womp. 😭"

# Pause execution for 5 seconds
sleep 5

# Print the thank you message
puts "\n\nThanks for watching! Tip your Commissioner!"

# Pause execution for 3 seconds
sleep 3

# Print the source code URL
puts "\n\nSource code available at: https://github.com/afxjzs/rfdgnfl-draft-order"

# Kill the sad trombone sound process
Process.kill("HUP", pid)
Process.wait(pid)

# Kill all remaining mpg123 processes
system('killall -q mpg123')

# Pause execution for 30 seconds
sleep 30