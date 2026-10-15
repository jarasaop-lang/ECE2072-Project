#Timing Analyzer
#Need to set an operating frequency for the clock, such that timing constraints are met  
#This checking propagation for paths from one register, due to logic, to another register 
#Each path must settle before the next clock edge

#get ports returns a list containing all instances with the name in {}; get_collection_size evaluates returns the length (0/1)
if {[get_collection_size [get_ports -nowarn {CLOCK_50}]] > 0} {
	create_clock -name clock_50 -period 20.000 [get_ports {CLOCK_50}] 
	#20ns period as thats the 50 MHz clock
	} else {
	create_clock -name key_clk -period 20.000 [get_ports {KEY[1]}]
	}
	
#adding uncertainty; assuming all clock edges aren't perfectly on time and leaving margin of error for that
	
derive_clock_uncertainty