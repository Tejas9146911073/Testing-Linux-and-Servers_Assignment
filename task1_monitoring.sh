#!/bin/bash
# Task 1: System Monitoring Setup
echo "--- Task 1: System Monitoring ---"
apt-get update && apt-get install -y htop sysstat >/dev/null 2>&1

REPORT_FILE="/var/log/system_monitor.log"
echo "System Monitoring Report - $(date)" > $REPORT_FILE
echo "--------------------------------" >> $REPORT_FILE

echo "1. Disk Usage (df -h):" >> $REPORT_FILE
df -h >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "2. Directory Usage (du -sh /var /etc /usr):" >> $REPORT_FILE
du -sh /var /etc /usr 2>/dev/null >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "3. Top 5 Resource-Intensive Processes (CPU):" >> $REPORT_FILE
ps aux --sort=-%cpu | head -n 6 >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "4. Top 5 Resource-Intensive Processes (Memory):" >> $REPORT_FILE
ps aux --sort=-%mem | head -n 6 >> $REPORT_FILE
echo "" >> $REPORT_FILE

cat $REPORT_FILE
echo "System Monitoring setup complete. Logs saved to $REPORT_FILE."
