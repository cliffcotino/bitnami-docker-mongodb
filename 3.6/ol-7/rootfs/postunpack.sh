#!/bin/bash

# shellcheck disable=SC1091

# Load libraries
. /libfs.sh
. /liblog.sh
. /libmongodb.sh

# Load MongoDB env. variables
eval "$(mongodb_env)"

for dir in "$MONGODB_TMP_DIR" "$MONGODB_LOG_DIR" "$MONGODB_CONFIG_DIR" "$MONGODB_DATA_DIR" "$MONGODB_PERSIST_DIR"; do
    info "ensure: $dir" 
    ensure_dir_exists "$dir"
done
chmod -R g+rwX "$MONGODB_TMP_DIR" "$MONGODB_LOG_DIR" "$MONGODB_CONFIG_DIR" "$MONGODB_DATA_DIR" "$MONGODB_PERSIST_DIR"

# Create .dbshell file to avoid error message
touch /.dbshell && chmod g+rw /.dbshell

# Redirect all logging to stdout
ln -sf /dev/stdout "$MONGODB_LOG_FILE"
