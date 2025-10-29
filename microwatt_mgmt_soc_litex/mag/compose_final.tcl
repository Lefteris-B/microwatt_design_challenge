#!/bin/env wish
drc off
random seed 16
load mgmt_soc -dereference
property GDS_FILE /home/iamme/asic_tools/caravel_mgmt_soc_litex/gds/mgmt_soc.gds
property GDS_START 0
select top cell
set bbox [box values]
load caravel_00000010_fill_pattern -silent
snap internal
box values {*}$bbox
paint comment
property GDS_FILE /home/iamme/asic_tools/caravel_mgmt_soc_litex/gds/caravel_00000010_fill_pattern.gds
property GDS_START 0
property FIXED_BBOX "$bbox"
load caravel_00000010 -silent
box values 0 0 0 0
box position 6um 6um
getcell mgmt_soc child 0 0
getcell caravel_00000010_fill_pattern child 0 0
box position 0 0
getcell advSeal_6um_gen
puts stdout "Writing final GDS. . . "
flush stdout
gds undefined allow
cif *hier write disable
gds write /home/iamme/asic_tools/caravel_mgmt_soc_litex/gds/caravel_00000010.gds
quit -noprompt
