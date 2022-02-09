
# ########################################################################
# file: myrom8.tcl   (c) 2022 by Anton Mause
#

#dbg file delete myrom8.vhd

# ########################################################################
# convert binary file to initialise vhdl memory block

# WatchOut: 
# This script assumes file size to be multiples of 4 (or fails)

# copy header into target
set outfile [open "../hdl/myrom8.vhd" w]
#dbg set outfile [open "myrom8.vhd" w]
set head [open "myrom8_head.vhd" r]
fcopy $head $outfile
close $head

# generate body
set infile [open "myrom.txt" r]
set two ""
set cnt 0

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
	
	if { [string length $two] == 0 } {
        set two $one
    } else {
        puts $outfile [format {    x"%-1s%-1s", -- %4s} $two $one $cnt]
        set two ""
		set cnt [expr $cnt +1]
	}
}
close $infile
    puts $outfile [format {    others=>x"00" ); }]
    puts $outfile [format {signal s_len : integer := %s;} $cnt]
    
# copy tail into target
set tail [open "myrom8_tail.vhd" r]
fcopy $tail $outfile
close $tail

close $outfile
