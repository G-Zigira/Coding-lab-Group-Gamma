#!/bin/bash

# Define base directories
log_dir="hospital_data/active_logs"
archive_root="hospital_data/archived_logs"

# Interactive menu loop
while true; do
  echo "Select log type to archive:"
  echo "1) Heart Rate"
  echo "2) Temperature"
  echo "3) Water Usage"
  read -p "Enter choice (1-3): " choice

  case $choice in
    1)
      log="$log_dir/heart_rate.log"
      archive_dir="$archive_root/heart_data_archive"
      break
      ;;
    2)
      log="$log_dir/temperature.log"
      archive_dir="$archive_root/temperature_data_archive"
      break
      ;;
    3)
      log="$log_dir/water_usage.log"
      archive_dir="$archive_root/water_usage_data_archive"
      break
      ;;
    *)
      echo "❌ Invalid choice. Please enter 1, 2, or 3."
      ;;
  esac
done

# Check if log file exists
if [ ! -f "$log" ]; then
  echo "🚨 Error: Log file '$log' not found in '$log_dir'."
  exit 1
fi

# Check if archive directory exists
if [ ! -d "$archive_dir" ]; then
  echo "🚨 Error: Archive directory '$archive_dir' not found."
  exit 1
fi

# Generate timestamp
timestamp=$(date +"%Y-%m-%d-%H:%M:%S")
filename=$(basename "$log")
archived_name="${filename%.*}_$timestamp.log"

# Move and rename the log file
mv "$log" "$archive_dir/$archived_name"
echo "✅ Archived '$filename' to '$archive_dir/$archived_name'"

# Create a new empty log file
touch "$log"
echo "🆕 Created new empty '$filename' in '$log_dir'"
