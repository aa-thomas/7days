#!/usr/bin/expect --

# 24 hour timeout; more than likely will change asap.
set timeout 86400

# variable for hour / minute for the 'settime' command for the 7 days to die console.
set hourfix 21
set minfix 59

# Spawn password-less telnet session to the 7days to die console only allowing localhost connections.
spawn telnet localhost 8081
sleep 1

# List current players active on the server; 7day's console command 'lp = listplayers'.
send "lp\n"
sleep 1

# Expect statement looking for an empty world.
expect "Total of 0 in the game"
sleep 1

# Check the server's day using the 7day's console command 'gt = gettime'.
send "gt\n"
sleep 1

# Expect statement looking for the server time presented from the last 7day's console command 'gettime'.
# The captured string is stored in the $expect_out(buffer) and a regular expression search is performed
# with the results stored as variables for additional logic checks.
expect -re "Day (.*)(.*)"
set string $expect_out(0,string)
set found [regexp -all { ([0-9][0-9]), ([0-9][0-9]):([0-9][0-9])} $string match day hour min] 
if {$found == 1} {
    puts "day is $day"
    puts "hour is $hour"
    puts "minute is $min"

# Error message when no mathces are found; possible changes in the & day's console syntax. 
} else {put "GOD AARON!\n"}
sleep 1

# The following checks to see if the day is divisble by seven and if the subsequent feral night hoard is supposed to spawn during the hours  22:00 pm to Midnight. 
if {$day % 7 == 0 && $hour >=22} {
    send_user "The world was abondon on a horde night, time will now be reset to Day $day, $hourfix:$minfix"
    send "st $day $hourfix $minfix\n"
} else {
    send_user {[Day $day % 7 != 0] Not a horde night!\n}
}

# The following checks to see if the day is divisble by seven minus one and if the subsequent feral night hoard is supposed to spawn during the hours Midnight to 06:00 am.
if {($day - 1) % 7 == 0 && $hour <= 05} {
    send_user "The world was abondon on a horde night, time will now be reset to Day $day, $hourfix:$minfix"
    set day [expr {$day - 1}] 
    send "st $day $hourfix $minfix\n"
} else {
    send_user {[Day $day % 7 != 0] Not a horde night!\n}
}
