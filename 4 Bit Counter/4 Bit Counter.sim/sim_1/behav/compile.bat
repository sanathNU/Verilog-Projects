@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;;C:/Xilinx/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=C:/Xilinx/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_behav --prj "C:/Users/FranticUser/Vivado Projects/4 Bit Counter/4 Bit Counter.sim/sim_1/behav/tb.prj"   xil_defaultlib.tb   xil_defaultlib.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
