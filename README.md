# Generator

The project is an implementation of a random bit generator based on [[1]](#1). The implementation uses the same parameters of the circuit as presented in the paper [[1]](#1). The testbench generates 8 * no bits in 0/1 text format. The results can be directly tested by NIST Statistical Test Suite.

# Requirements

Running the simulation requires having the ghdl program installed.
Project was tested on Debian, where ghdl can be installed using ``apt``.

``
apt install ghdl -y
``

# Simulation

To generate bitstream with random bits, script ``sim.sh`` can be running in system terminal.

``
./sim.sh
``

To control number of bits change **no** parameter in generatortb.vhd. By default testbench generates 1000000 bits(8 * 125000). Results are written in **bitstream** file. Initial parameter **x0** can be changed in generatortb.vhd. Labmda is hardcoded in generator.vhd as a parameter of multiplication.

# References

<a id="1">[1]</a> 
Sayed, Wafaa & Radwan, Ahmed & Rezk, Ahmed & Fahmy, Hossam. (2017). Finite Precision Logistic Map between Computational Efficiency and Accuracy with Encryption Applications. Complexity. 2017. 1-21. 10.1155/2017/8692046. 