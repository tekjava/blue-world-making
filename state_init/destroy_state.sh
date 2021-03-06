#!/usr/bin/env bash

REPO_NAME="nope"
FILE="../cross-phase-configuration"

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Determined state in $line"
    REPO_NAME=$line
done < "$FILE"

echo "Starting destroy for $REPO_NAME."

echo 'yes' | terraform destroy -var=repo_name=$REPO_NAME

rm $FILE

echo "Destruction completed."

# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# -r prevents backslash escapes from being interpreted.
# || [[ -n $line ]] prevents the last line from being ignored if it doesn't end with a \n (since read returns a non-zero exit code when it encounters EOF).
