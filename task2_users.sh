#!/bin/bash
# Task 2: User Management and Access Control
echo "--- Task 2: User Management and Access Control ---"

# Create users
useradd -m -s /bin/bash Sarah
useradd -m -s /bin/bash mike

# Set secure passwords
echo "Sarah:ComplexPass123!" | chpasswd
echo "mike:SecurePass456#" | chpasswd

# Setup dedicated directories
mkdir -p /home/Sarah/workspace
mkdir -p /home/mike/workspace

# Set ownership and permissions (only respective users can access)
chown -R Sarah:Sarah /home/Sarah/workspace
chmod 700 /home/Sarah/workspace

chown -R mike:mike /home/mike/workspace
chmod 700 /home/mike/workspace

# Password policy (expiration every 30 days)
chage -M 30 Sarah
chage -M 30 mike

# Verify
echo "User Account Details:"
grep -E '^(Sarah|mike):' /etc/passwd
echo "Password Expiration Details (Sarah):"
chage -l Sarah | grep "Maximum number of days"
echo "Directory Permissions:"
ls -ld /home/Sarah/workspace
ls -ld /home/mike/workspace

echo "User Management setup complete."
