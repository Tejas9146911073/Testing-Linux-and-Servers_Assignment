# DevOps Practice Assignment Report

## Table of Contents
1. [Introduction](#introduction)
2. [Task 1: System Monitoring Setup](#task-1-system-monitoring-setup)
3. [Task 2: User Management and Access Control](#task-2-user-management-and-access-control)
4. [Task 3: Backup Configuration for Web Servers](#task-3-backup-configuration-for-web-servers)
5. [Conclusion](#conclusion)

---

## Introduction
This report summarizes the implementation steps for setting up a secure, monitored, and well-maintained development environment for the new developers, Sarah and Mike. The environment configuration was completely automated using Bash scripts and validated within an Ubuntu Linux environment.

---

## Task 1: System Monitoring Setup

### Implementation Steps
1. Installed essential monitoring tools (`htop` and `sysstat`) to gain visibility into CPU, memory, and process usage.
2. Formulated a script that utilizes `df -h` and `du -sh` to precisely identify disk consumption.
3. Extracted the top 5 resource-intensive applications for CPU and memory by parsing the output of `ps aux`.
4. Automated the reporting process to save metrics directly to `/var/log/system_monitor.log`.

### Terminal Output
```
System Monitoring Report - Fri Mar 20 17:48:44 UTC 2026
--------------------------------
1. Disk Usage (df -h):
Filesystem      Size  Used Avail Use% Mounted on
overlay         453G  1.6G  428G   1% /
tmpfs            64M     0   64M   0% /dev
shm              64M     0   64M   0% /dev/shm
/dev/vda1       453G  1.6G  428G   1% /etc/hosts
tmpfs           3.9G     0  3.9G   0% /proc/scsi
tmpfs           3.9G     0  3.9G   0% /sys/firmware

2. Directory Usage (du -sh /var /etc /usr):
78M	/var
936K	/etc
150M	/usr

3. Top 5 Resource-Intensive Processes (CPU):
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   3876  2552 ?        Ss   17:48   0:00 /bin/bash /root/run_all.sh
root         7  0.0  0.0   3876  2676 ?        S    17:48   0:00 /bin/bash ./task1_monitoring.sh
root       214  0.0  0.0   6440  2276 ?        R    17:48   0:00 ps aux --sort=-%cpu
root       215  0.0  0.0   2236   828 ?        S    17:48   0:00 head -n 6

4. Top 5 Resource-Intensive Processes (Memory):
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         7  0.0  0.0   3876  2676 ?        S    17:48   0:00 /bin/bash ./task1_monitoring.sh
root         1  0.0  0.0   3876  2552 ?        Ss   17:48   0:00 /bin/bash /root/run_all.sh
root       216  0.0  0.0   6440  2340 ?        R    17:48   0:00 ps aux --sort=-%mem
root       217  0.0  0.0   2236   828 ?        S    17:48   0:00 head -n 6
```

---

## Task 2: User Management and Access Control

### Implementation Steps
1. Created user accounts (`Sarah` and `mike`) with standard `/bin/bash` shells.
2. Secured their accounts by setting strong initial passwords and enforcing a strict 30-day password expiration policy utilizing `chage`.
3. Established isolated, dedicated workspaces (`/home/Sarah/workspace` and `/home/mike/workspace`), ensuring full confidentiality by restricting access via `chmod 700` and `chown`.

### Terminal Output
```
User Account Details:
Sarah:x:1000:1000::/home/Sarah:/bin/bash
mike:x:1001:1001::/home/mike:/bin/bash
Password Expiration Details (Sarah):
Maximum number of days between password change		: 30
Directory Permissions:
drwx------ 2 Sarah Sarah 4096 Mar 20 17:48 /home/Sarah/workspace
drwx------ 2 mike mike 4096 Mar 20 17:48 /home/mike/workspace
```

---

## Task 3: Backup Configuration for Web Servers

### Implementation Steps
1. Created specialized, automated backup shell scripts for both Apache and Nginx environments.
2. Configured user-specific `crontab` entries corresponding strictly to the Tuesday 12:00 AM cadence (`0 0 * * 2`).
3. Formatted backup generated files dynamically based on dates (e.g., `apache_backup_YYYY-MM-DD.tar.gz`) stored uniformly inside a protected `/backups/` directory.
4. Programmed immediate post-backup verification to confirm tarball integrity utilizing `tar -tzf`.

### Terminal Output
```
Cron jobs configured:
Sarah's crontab:
0 0 * * 2 /usr/local/bin/backup_apache.sh
Mike's crontab:
0 0 * * 2 /usr/local/bin/backup_nginx.sh
Verifying backup integrity in /backups/:
total 8.0K
-rw-r--r-- 1 root root 231 Mar 20 17:48 apache_backup_2026-03-20.tar.gz
-rw-r--r-- 1 root root 231 Mar 20 17:48 nginx_backup_2026-03-20.tar.gz
Integrity check (listing files in Apache backup):
etc/httpd/
etc/httpd/httpd.conf
var/www/html/
var/www/html/index.html
Integrity check (listing files in Nginx backup):
etc/nginx/
etc/nginx/nginx.conf
usr/share/nginx/html/
usr/share/nginx/html/index.html
```

---

## Conclusion
The development environments for both Sarah and Mike have been properly deployed according to organizational security rules. System resources can be actively monitored, access is securely cordoned off per user, and both Apache and Nginx web roots and configurations are safeguarded incrementally by the new weekly automated backups.
