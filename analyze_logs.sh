#!/usr/bin/env bash
#-------------------------------
# Author: <Denzel>
#Description:
# This script anaylzes log files such as (heart rate, temperature, or water usage)
# and gives a summary report to reports/analysis_report.txt
#-------------------------------


Rep_Dir="reports"
Rep_File="$Rep_Dir/analysis_report.txt"

mkdir -p "$Rep_Dir" #TO make sure that the report directory exist

#The display menu 
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
echo -n "Enter choice (1-3):"

read choice

#if statement for validating the input 

if [[ "$choice" !=  "1" && "$choice" != "2" && "$choice" != "3" ]]; then
	echo "Invalid choice! Please enter 1, 2, or 3."
	exit 1
fi

#Selecting the case log file according to the input

case $choice in
	1)logfile="heart_rate.log" ;;
	2)logfile="temperature.log" ;;
	3)logfile="water_usage.log" ;;
esac

#If statement to check if the file exist 

if [[ ! -f "#logfile" ]]; then
	echo "Error: $logfile does not exist!"
	exit 1
fi

#Start Analysis
echo "Analyzing $logfile..."
echo "---------------------------------------------------"
echo "Analysis Date: $(date)"
echo "Log File: $logfile"
echo "---------------------------------------------------"

#Count occurences for each devices ( assuming each line contains a device name)

echo "Device count summary"
awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr 

#Timestamp of first and last entry (assuming timestamp is the first field)
first_time=$(head -1 "$logfile" | awk '{print $1}')
last_time=$(tail -1 "$logfile" | awk '{print $1}')

echo "----------------------------------------------------"
echo "First Entry Timestamp: $first_time"
echo "Last Entry Timestamp: $last_time"
echo "----------------------------------------------------"

#Appending results to report
{
    echo "===== Log Analysis Report ====="
    echo "Date: $(date)"
    echo "File analyzed: $logfile"
    echo "Device counts:"
    awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr
    echo "First entry: $first_time"
    echo "Last entry: $last_time"
    echo "--------------------------------------------"
} >> "$REPORT_FILE"

echo "Analysis complete. Report saved to $REPORT_FILE"


