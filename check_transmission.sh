#!/bin/bash

if [ -z "$TR_AUTH" ]; then
	echo "Transmission UNKNOWN TR_AUTH not set"
	exit 3
fi

if [ -z "$TR_HOST" ]; then
	TR_HOST="localhost:9091"
fi

OUT=$(transmission-remote "$TR_HOST" -ne -st 2>/dev/null)

if [ $? != 0 ]; then
	echo "Transmission CRITICAL Could not connect to daemon"
	exit 2
fi

CUT=$(echo "$OUT" | pcregrep -o1 'Uploaded:\s+(\S+)')
SESSION_UPLOADED=$(echo "$CUT" | head -n1 | sed -e "s/\s//")
TOTAL_UPLOADED=$(echo "$CUT" | tail -n1 | sed -e "s/\s//")

CUT=$(echo "$OUT" | pcregrep -o1 'Downloaded:\s+(\S+)')
SESSION_DOWNLOADED=$(echo "$CUT" | head -n1 | sed -e "s/\s//")
TOTAL_DOWNLOADED=$(echo "$CUT" | tail -n1 | sed -e "s/\s//")

CUT=$(echo "$OUT" | pcregrep -o1 'Ratio:\s+(\S+)')
SESSION_RATIO=$(echo "$CUT" | head -n1)
TOTAL_RATIO=$(echo "$CUT" | tail -n1)

CUT=$(echo "$OUT" | pcregrep -o1 'Ratio:\s+(\S+)')
SESSION_DURATION=$(echo "$CUT" | head -n1)
TOTAL_DURATION=$(echo "$CUT" | tail -n1)

echo "Transmission OK
session_uploaded=$SESSION_UPLOADED
session_downloaded=$SESSION_DOWNLOADED
session_ratio=$SESSION_RATIO
session_duration=$SESSION_DURATION
total_uploaded=$TOTAL_UPLOADED
total_downloaded=$TOTAL_DOWNLOADED
total_ratio=$TOTAL_RATIO
total_duration=$TOTAL_DURATION"
exit 0

