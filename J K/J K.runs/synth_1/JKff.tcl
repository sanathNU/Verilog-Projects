# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/FranticUser/Desktop/Code/Vivado Projects/J K/J K.cache/wt} [current_project]
set_property parent.project_path {C:/Users/FranticUser/Desktop/Code/Vivado Projects/J K/J K.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {{C:/Users/FranticUser/Desktop/Code/Vivado Projects/J K/J K.srcs/sources_1/new/JKff.v}}
read_xdc {{C:/Users/FranticUser/Desktop/Code/Vivado Projects/J K/ELEV-BASYS3.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/FranticUser/Desktop/Code/Vivado Projects/J K/ELEV-BASYS3.xdc}}]

synth_design -top JKff -part xc7a35tcpg236-1
write_checkpoint -noxdef JKff.dcp
catch { report_utilization -file JKff_utilization_synth.rpt -pb JKff_utilization_synth.pb }
