# Microsemi Tcl Script for Microsemi Libero SoC
# (c) 2022 by Anton Mause 
#
# Microsemi Dummy Block Flow Design using M2GL010-TQ144
#

source ../scripts/g4config.tcl
puts -nonewline "Targeting Libero Version:" 
puts $LIBERO_VERSION

# 
set BOARD_NAME         g4
set NAME_PROJ          crc32eth
set NAME_PROJ          $BOARD_NAME$NAME_PROJ
#
set PROJ_DESCRIPTION   "G4 M2GL010 Microchip Block Flow crc32eth"
set PATH_DESTINATION   "../.."
set PATH_DESTINATION   $PATH_DESTINATION/$LIBERO_VERSION

set PATH_SOURCE   [pwd]
set PATH_PROJ     $PATH_DESTINATION/$NAME_PROJ

# where are we
puts -nonewline "Sources Path  : "
puts $PATH_SOURCE
#
puts -nonewline "Proj Path   : "
puts $PATH_PROJ
#

# create new base project
new_project -location $PATH_PROJ -name $NAME_PROJ -project_description $PROJ_DESCRIPTION -block_mode 1 -standalone_peripheral_initialization 0 -instantiate_in_smartdesign 0 -ondemand_build_dh 1 -use_relative_path 0 -linked_files_root_dir_env {} -hdl {VHDL} -family {IGLOO2} -die {M2GL010} -package {144 TQ} -speed {-1} -die_voltage {1.2} -part_range {COM} -adv_options {DSW_VCCA_VOLTAGE_RAMP_RATE:1_MS} -adv_options {IO_DEFT_STD:LVCMOS 2.5V} -adv_options {PLL_SUPPLY:PLL_SUPPLY_25} -adv_options {RESTRICTPROBEPINS:0} -adv_options {RESTRICTSPIPINS:0} -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} -adv_options {TEMPR:COM} -adv_options {VCCI_1.2_VOLTR:COM} -adv_options {VCCI_1.5_VOLTR:COM} -adv_options {VCCI_1.8_VOLTR:COM} -adv_options {VCCI_2.5_VOLTR:COM} -adv_options {VCCI_3.3_VOLTR:COM} -adv_options {VOLTR:COM} 

import_files \
         -convert_EDN_to_HDL 0 \
         -hdl_source {../hdl/fcs4.vhd} \
         -hdl_source {../hdl/myrom32.vhd} \
         -hdl_source {../hdl/fcs2.vhd} \
         -hdl_source {../hdl/myrom16.vhd} \
         -hdl_source {../hdl/fcs1.vhd} \
         -hdl_source {../hdl/myrom8.vhd} \
         -hdl_source {../hdl/crc32x8.vhd} \
         -hdl_source {../hdl/rom2axi8s.vhd} 
import_files \
         -convert_EDN_to_HDL 0 \
         -library {work} \
         -sdc {../scripts/g4timing.sdc} 
import_files \
    -convert_EDN_to_HDL 0 \
    -library {work} \
    -simulation {../simulation/wave-fcs1.do} 
import_files \
         -convert_EDN_to_HDL 0 \
         -library {work} \
         -stimulus {../simulation/fcs1_tb.vhd} \
         -stimulus {../simulation/fcs2_tb.vhd} \
         -stimulus {../simulation/rom2axi8s_tb.vhd} 
build_design_hierarchy 
save_project 

set_root -module {fcs1::work} 
organize_tool_files -tool {SYNTHESIZE} -file $PATH_PROJ/constraint/g4timing.sdc -module {fcs1::work} -input_type {constraint} 
organize_tool_files -tool {PLACEROUTE} -file $PATH_PROJ/constraint/g4timing.sdc -module {fcs1::work} -input_type {constraint} 
organize_tool_files -tool {VERIFYTIMING} -file $PATH_PROJ/constraint/g4timing.sdc -module {fcs1::work} -input_type {constraint} 

organize_tool_files -tool {SIM_PRESYNTH} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 
organize_tool_files -tool {SIM_POSTSYNTH} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 
organize_tool_files -tool {SIM_POSTLAYOUT} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 

set_root -module {fcs1::work} 
save_project 
