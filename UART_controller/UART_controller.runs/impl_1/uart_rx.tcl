proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir {C:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/UART_controller.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/UART_controller.xpr} [current_project]
  set_property ip_repo_paths {{c:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/UART_controller.cache/ip}} [current_project]
  set_property ip_output_repo {{c:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/UART_controller.cache/ip}} [current_project]
  add_files -quiet {{C:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/UART_controller.runs/synth_1/uart_rx.dcp}}
  read_xdc {{C:/Users/FranticUser/Desktop/Code/Vivado Projects/UART_controller/ELEV-BASYS3.xdc}}
  link_design -top uart_rx -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force uart_rx_opt.dcp
  catch {report_drc -file uart_rx_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file uart_rx.hwdef}
  place_design 
  write_checkpoint -force uart_rx_placed.dcp
  catch { report_io -file uart_rx_io_placed.rpt }
  catch { report_utilization -file uart_rx_utilization_placed.rpt -pb uart_rx_utilization_placed.pb }
  catch { report_control_sets -verbose -file uart_rx_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force uart_rx_routed.dcp
  catch { report_drc -file uart_rx_drc_routed.rpt -pb uart_rx_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file uart_rx_timing_summary_routed.rpt -rpx uart_rx_timing_summary_routed.rpx }
  catch { report_power -file uart_rx_power_routed.rpt -pb uart_rx_power_summary_routed.pb }
  catch { report_route_status -file uart_rx_route_status.rpt -pb uart_rx_route_status.pb }
  catch { report_clock_utilization -file uart_rx_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force uart_rx.bit 
  catch { write_sysdef -hwdef uart_rx.hwdef -bitfile uart_rx.bit -meminfo uart_rx.mmi -ltxfile debug_nets.ltx -file uart_rx.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

