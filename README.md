
# myEth

2022 by Anton Mause

### Basic Ethernet function blocks in VHDL

What I found so far is Verilog, compiles to an empty netlist, 
compiles to a way too big netlist (on Microsemi FPGA), is a Mega project, 
too flexible, gives too slow netlist, ...

### Environment :
The current snapshot is intended to use Libero SoC version 2021.3 (2022q1), last test on Windows 10 Ent.

Unpack ./myEth-RevXYZ.zip to your projects directory.

Edit ./scripts/g?config.tcl if you use older Libero, or even checkout older repo.

run : Libero -> Project -> Execute Script -> g?crc32eth_create.tcl

select frame check sum bus width you like
- fcs1 = 8 bit, one byte
- fcs2 = 16 bit, two byte
- fcs4 = 32 bit, one word

rom2axi is a test pattern generator, work in progress

### Resource utilisation :
- 44 LUT4 for the one Byte CRC only 
- to project crc32x8.vhd 

### Performance :
- Microsemi Gen4 Igloo2
- G4 400+ MHz, for 8 bit,
- G4 300+ MHz, for 16 bit
- G4 250+ MHz, for 32 bit 

- Microsemi Gen5 PolarFire
- G5 500  MHz, for 8 bit
- G5 450+ MHz, for 16 bit
- G5 500  MHz, for 32 bit

### Verification :

- copy your test frame to use into ./software/myrom.txt

- run : Libero -> Project -> Execute Script -> myrom8.tcl

- this will update hdl/myrom8.vhd

- select fcs1 as top project

- run simulation

### ToDo / Ideas :
- a lot! including documentation :-)
- this is to back up my ideas, not a real project or product
- this has not been run on real hardware ... ,
- ... BUT the testbench gives the expected results
- testbench expects memory without pipelining (see myrom)