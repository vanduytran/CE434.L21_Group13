@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Sat Mar 20 08:45:13 +0700 2021
REM SW Build 3064766 on Wed Nov 18 09:12:45 MST 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim TestBench_Calculate_Result_behav -key {Behavioral:sim_1:Functional:TestBench_Calculate_Result} -tclbatch TestBench_Calculate_Result.tcl -view E:/Hoc_Tap/Nam_3_Ki_2/Chuyen_De_Thiet_Ke_Vi_Mach_1/Exercises/Week_2/Convert_RGB_to_Gray_Scale/TestBench_Calculate_Result_behav.wcfg -view E:/Hoc_Tap/Nam_3_Ki_2/Chuyen_De_Thiet_Ke_Vi_Mach_1/Exercises/Week_2/Convert_RGB_to_Gray_Scale/TestBench_Calculate_Result_behav1.wcfg -log simulate.log"
call xsim  TestBench_Calculate_Result_behav -key {Behavioral:sim_1:Functional:TestBench_Calculate_Result} -tclbatch TestBench_Calculate_Result.tcl -view E:/Hoc_Tap/Nam_3_Ki_2/Chuyen_De_Thiet_Ke_Vi_Mach_1/Exercises/Week_2/Convert_RGB_to_Gray_Scale/TestBench_Calculate_Result_behav.wcfg -view E:/Hoc_Tap/Nam_3_Ki_2/Chuyen_De_Thiet_Ke_Vi_Mach_1/Exercises/Week_2/Convert_RGB_to_Gray_Scale/TestBench_Calculate_Result_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
