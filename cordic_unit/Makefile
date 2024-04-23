FILE_LIST := -F ./file.fl
cmp:    
	vcs -R -full64 -fsdb +define+FSDB -debug_pp +vcd+vcdpluson -sverilog -l run.log $(FILE_LIST) -timescale=1ns/1ps -LDFLAGS -Wl,--no-as-needed

