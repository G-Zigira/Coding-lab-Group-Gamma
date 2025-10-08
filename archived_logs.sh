#!/bin/bash

# Set up directories for current and archived hospital logs
lgdir="hospital_data/active_logs"
arcroot="hospital_data/archived_logs"

# Keep asking the user which log they want to archive until a valid choice is made
while true; do
  echo "Select log type to archive:"
  echo "1) Heart Rate"
  echo "2) Temperature"
  echo "3) Water Usage"
  read -p "Enter choice (1-3): " choice

  case $choice in
    1)
      log="$lgdir/heart_rate.log"
      arcdir="$arcroot/heart_data_archive"
      break
      ;;
    2)
      log="$lgdir/temperature.log"
      arcdir="$arcroot/temperature_data_archive"
      break
      ;;
    3)
      log="$lgdir/water_usage.log"
      arcdir="$arcroot/water_usage_data_archive"
      break
      ;;
    *)
      echo " Invalid option. Please enter 1, 2, or 3."
      ;;
  esac
done

# Verify that the selected log file actually exists
if [ ! -f "$log" ]; then
  echo " Error: Log file '$log' not found in '$lgdir'."
  exit 1
fi

# Ensure the target archive directory exists before moving the file
if [ ! -d "$arcdir" ]; then
  echo " Error: Archive directory '$arcdir' not found."
  exit 1
fi

# Create a timestamp to uniquely name the archived log
timestamp=$(date +"%Y-%m-%d-%H:%M:%S")
filename=$(basename "$log")
arcname="${filename%.*}_$timestamp.log"

# Move the existing log to its archive folder with a timestamp
mv "$log" "$arcdir/$arcname"
echo " Successfully archived '$filename' to '$arcdir/$arcname'"

# Generate a new empty log file to continue collecting new data
touch "$log"
echo "Created new empty '$filename' in '$lgdir'"
