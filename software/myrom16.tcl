
# ########################################################################
# file: myrom16.tcl   (c) 2022 by Anton Mause
#

#dbg file delete myrom16.vhd

# ########################################################################
# convert binary file to initialise vhdl memory block

# WatchOut: 
# This script assumes file size to be multiples of 4 (or fails)

# copy header into target
set outfile [open "../hdl/myrom16.vhd" w]
#dbg set outfile [open "myrom16.vhd" w]
set head [open "myrom16_head.vhd" r]
fcopy $head $outfile
close $head

# generate body
set infile [open "myrom.txt" r]
set two ""

while { 1 } {

	# Read one byte from the file.
	set one [read $infile 1]

    # Stop if we've reached end of file
	if { [string length $one] == 0 } {
        break
    }

	if { [string is space $one] == 1 } {
        continue
    }
	
	if { [string length $two] < 3 } {
        set two $two$one
    } else {
        puts $outfile [format {    x"%-3s%-1s",} $two $one]
        set two ""
	}
}
close $infile

# copy tail into target
set tail [open "myrom16_tail.vhd" r]
fcopy $tail $outfile
close $tail

close $outfile

# source ./script.tcl  << how to call script
#     x"01", x"23", x"34", x"54", 
