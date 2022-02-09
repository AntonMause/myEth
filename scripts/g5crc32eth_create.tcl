# Microsemi Tcl Script for Microsemi Libero SoC
# (c) 2022 by Anton Mause 
#
# Microsemi Dummy Block Flow Design using MPF050T-FCS325
#

source ../scripts/g5config.tcl
puts -nonewline "Targeting Libero Version:" 
puts $LIBERO_VERSION

# 
set BOARD_NAME         g5
set NAME_PROJ          crc32eth
set NAME_PROJ          $BOARD_NAME$NAME_PROJ
#
set PROJ_DESCRIPTION   "G5 MPF050T Microchip Block Flow crc32eth"
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
new_project -location $PATH_PROJ -name $NAME_PROJ -project_description $PROJ_DESCRIPTION -block_mode 1 -standalone_peripheral_initialization 0 -instantiate_in_smartdesign 1 -ondemand_build_dh 1 -use_relative_path 0 -linked_files_root_dir_env {} -hdl {VHDL} -family {PolarFire} -die {MPF050T} -package {FCSG325_Eval} -speed {-1} -die_voltage {1.0} -part_range {EXT} -adv_options {IO_DEFT_STD:LVCMOS 1.8V} -adv_options {RESTRICTPROBEPINS:0} -adv_options {RESTRICTSPIPINS:0} -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} -adv_options {TEMPR:EXT} -adv_options {VCCI_1.2_VOLTR:EXT} -adv_options {VCCI_1.5_VOLTR:EXT} -adv_options {VCCI_1.8_VOLTR:EXT} -adv_options {VCCI_2.5_VOLTR:EXT} -adv_options {VCCI_3.3_VOLTR:EXT} -adv_options {VOLTR:EXT} 
set_device -family {PolarFire} -die {MPF050T} -package {FCSG325_Eval} -speed {-1} -die_voltage {1.05} -part_range {EXT} -adv_options {IO_DEFT_STD:LVCMOS 1.8V} -adv_options {RESTRICTPROBEPINS:0} -adv_options {RESTRICTSPIPINS:0} -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} -adv_options {TEMPR:EXT} -adv_options {VCCI_1.2_VOLTR:EXT} -adv_options {VCCI_1.5_VOLTR:EXT} -adv_options {VCCI_1.8_VOLTR:EXT} -adv_options {VCCI_2.5_VOLTR:EXT} -adv_options {VCCI_3.3_VOLTR:EXT} -adv_options {VOLTR:EXT} 

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
         -sdc {../scripts/g5timing.sdc} 
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
organize_tool_files -tool {SYNTHESIZE} -file $PATH_PROJ/constraint/g5timing.sdc -module {fcs1::work} -input_type {constraint} 
organize_tool_files -tool {PLACEROUTE} -file $PATH_PROJ/constraint/g5timing.sdc -module {fcs1::work} -input_type {constraint} 
organize_tool_files -tool {VERIFYTIMING} -file $PATH_PROJ/constraint/g5timing.sdc -module {fcs1::work} -input_type {constraint} 

organize_tool_files -tool {SIM_PRESYNTH} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 
organize_tool_files -tool {SIM_POSTSYNTH} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 
organize_tool_files -tool {SIM_POSTLAYOUT} -file $PATH_PROJ/stimulus/fcs1_tb.vhd -module {fcs1::work} -input_type {stimulus} 

set_root -module {fcs1::work} 
save_project 
