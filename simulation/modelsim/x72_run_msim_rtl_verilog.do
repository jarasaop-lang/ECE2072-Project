transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/proc_extension_tb.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/proc_extension.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/BCD_tickfsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/display_divide.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/display.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/BCD.v}
vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/components.v}

vlog -vlog01compat -work work +incdir+C:/Users/AND0036/OneDrive\ -\ Department\ of\ Education/Desktop/University/Year\ 2\ Semester\ 1/ECE2071/ECE2072-Project {C:/Users/AND0036/OneDrive - Department of Education/Desktop/University/Year 2 Semester 1/ECE2071/ECE2072-Project/proc_extension_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  proc_extension_tb

add wave *
view structure
view signals
run -all
