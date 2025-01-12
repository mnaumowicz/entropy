ghdl -a --std=08 -fsynopsys generator.vhd generatortb.vhd
ghdl -e --std=08 -fsynopsys generatortb
ghdl -r --std=08 -fsynopsys generatortb --vcd-nodate
