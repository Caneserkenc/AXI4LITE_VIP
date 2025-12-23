#sabit derleme dosyası 
-sv
-uvm 1.2
+acc+b
+incdir+..

-top tb_top

#burada da tanımlanabilir 
#+UVM_VERBOSITY=UVM_HIGH
#+UVM_TESTNAME=axi4lite_test
#-waves waves.mxd

../rtl/axi4_lite_slave.sv
../agent/axi4lite_if.sv
../axi4lite_pkg.sv
../testbench/tb_top.sv