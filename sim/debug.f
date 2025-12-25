#sık değişebilecek yapılar- simulasyon ayarları

//  Test Seçimi 
 //+UVM_TESTNAME=axi4lite_test
 +UVM_TESTNAME=axi4lite_stress_test

// Gözlem Ayarları 
+UVM_VERBOSITY=UVM_HIGH
-waves waves.mxd

# terminal çalıştırma komutu (dsim -f run.f -f debug.f)