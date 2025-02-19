#!/bin/bash

# Check if an argument (number N) is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <number>"
  exit 1
fi

# Store the argument in a variable
N="$1"

# Check if the argument is a number
if ! [[ "$N" =~ ^[0-9]+$ ]]; then
  echo "Error: Argument must be a number."
  exit 1
fi

# Create the 'clusters' directory if it doesn't exist
mkdir -p clusters

# Loop from 1 to N
for i in $(seq 1 "$N"); do
  # Construct the directory name
  dir_name="k$i"
  cluster_dir="clusters/$dir_name"

  # Create the directory if it doesn't exist
  if [ ! -d "$cluster_dir" ]; then
    echo "Creating directory: $cluster_dir"
    mkdir "$cluster_dir"
  else
    echo "Directory already exists: $cluster_dir"
  fi

  # Copy YAML files from 'vanilla' to the newly created directory
  if [ -d "vanilla" ]; then
    echo "Copying YAML files from vanilla to $cluster_dir"
    cp vanilla/*.yaml "$cluster_dir"
  else
    echo "Warning: 'vanilla' directory not found. Skipping YAML copy for $cluster_dir."
  fi
done

echo "Script finished."
