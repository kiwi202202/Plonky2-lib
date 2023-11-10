#!/bin/bash

# chmod +x batch_test.sh
# ./batch_test.sh
# sudo apt-get install bc




cd ..

# Define the number of runs and the test command.
NUM_RUNS=3
TEST_COMMAND="cargo test --package Plonky2-lib --release --lib -- ecdsa::gadgets::ecdsa::tests::test_batch_ecdsa_circuit_narrow --exact --nocapture --ignored"

# Temporary file to store results.
TIMINGS_FILE="timings_origin.txt"
> "$TIMINGS_FILE" # Clear the timings file contents before starting the tests.

# Run the test command the specified number of times and capture the timing.
for (( run=1; run<=NUM_RUNS; run++ )); do
    echo "Run #$run"
    # Run the test and capture timing data.
    $TEST_COMMAND 2>&1 | tee -a "$TIMINGS_FILE"
done



cd scripts/
#!/bin/bash

# cd ../Plonky2-lib

# # Define the number of runs and the test command.
# NUM_RUNS=3
# TEST_COMMAND="cargo test --package Plonky2-lib --release --lib -- ecdsa::gadgets::ecdsa::tests::test_batch_ecdsa_circuit_narrow --exact --nocapture --ignored"

# # Temporary file to store results.
# TIMINGS_FILE="timings.txt"
# > "$TIMINGS_FILE" # Clear the timings file contents before starting the tests.

# # Define an associative array to store cumulative times.
# declare -A timings

# # Initialize sum and count for each timing measure.
# init_timing_keys=() # Use this array to keep track of which keys were added dynamically.

# # A function to parse and sum timings from one run.
# parse_and_sum_timings() {
#     while read -r line; do
#         if [[ $line =~ ^\[TRACE\ plonky2::util::timing\] ]]; then
#             # Extract timing data using regex.
#             time=$(echo "$line" | grep -oP '\d+\.\d+(?=s to)')
#             label=$(echo "$line" | grep -oP '(?<=] ).*(?=:)')
#             if [ ! ${timings[$label]+_} ]; then
#                 # If this key is encountered the first time, add it to init_timing_keys.
#                 init_timing_keys+=("$label")
#             fi
#             timings[$label]=$(echo "${timings[$label]:-0} + $time" | bc)
#         fi
#     done < "$1" # Pass the file name as an argument to the function.
# }

# # Run the test command the specified number of times and capture the timing.
# for (( run=1; run<=NUM_RUNS; run++ )); do
#     echo "Run #$run"
#     # Run the test and capture timing data into a temporary file.
#     TEMP_FILE=$(mktemp)
#     $TEST_COMMAND &> "$TEMP_FILE"
#     parse_and_sum_timings "$TEMP_FILE"
#     cat "$TEMP_FILE" >> "$TIMINGS_FILE"
#     rm "$TEMP_FILE"
# done

# # Calculate averages.
# for label in "${init_timing_keys[@]}"; do
#     average=$(echo "${timings[$label]} / $NUM_RUNS" | bc -l)
#     printf "[TRACE plonky2::util::timing] %.4fs to %s\n" "$average" "$label"
# done

# cd ../scripts
