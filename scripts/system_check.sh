#!/bin/bash
mkdir -p ../logs
DATE=$(date '2026-03-30 01:57')
LOGFILE="../logs/system_report_$2026-03-30 01:57.log"
# 1. Disk usage
echo -e "\n--- Disk Usage ---" | tee -a  "../logs/system_report_$2026-03-30 01:57.log"
df -h | tee -a "$../logs/system_report_$2026-03-30 01:57.log"

# Warn if any disk usage exceeds 80%
echo -e "\n--- Disk Usage Warnings ---" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
while read -r filesystem size used avail perc mount; do
    usage=${84}   # remove % sign
    if [ "$84" -ge 80 ]; then
        echo "Warning: $filesystem on $mount is ${perc} full!" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
    fi
done < <(df -h | tail -n +2)

# 2. Memory usage
echo -e "\n--- Memory Usage ---" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
free -m | tee -a "$../logs/system_report_$2026-03-30 01:57.log"

# 3. CPU load
echo -e "\n--- CPU Load ---" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
uptime | tee -a "$../logs/system_report_$2026-03-30 01:57.log"

# 4. Total running processes
echo -e "\n--- Total Running Processes ---" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
ps aux | wc -l | tee -a "$../logs/system_report_$2026-03-30 01:57.log"

# 5. Top 5 memory-consuming processes
echo -e "\n--- Top 5 Memory-Consuming Processes ---" | tee -a "$../logs/system_report_$2026-03-30 01:57.log"
ps aux --sort=-%mem | head -n 6 | tee -a "$../logs/system_report_$2026-03-30 01:57.log"

echo -e "\nSystem report saved to $../logs/system_report_$2026-03-30 01:57.log"

