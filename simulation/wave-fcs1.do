onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rom2axi8s_tb/SYSCLK
add wave -noupdate /rom2axi8s_tb/NSYSRESET
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/s_valid
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/s_ready
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/s_both
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/u_idx
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/s_dat
add wave -noupdate /rom2axi8s_tb/rom2axi8s_0/s_last
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32668133 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1920931606 fs} {2167922494 fs}
