#!/bin/bash
# Wrapper to run all tasks
./task1_monitoring.sh
echo ""
./task2_users.sh
echo ""
./task3_backups.sh
echo ""
echo "=== ALL TASKS COMPLETED SUCCESSFULLY ==="
