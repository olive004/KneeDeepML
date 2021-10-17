#!/bin/bash
# file_num=$(ls multicoil_val/ | wc -l)

# generate dummy files
for i in {1..10}
do
   touch multicoil_val/$i
done

# for i in $(ls multicoil_val/)
file_num=$(ls multicoil_val/ | wc -l)
while [[ "$file_num" -ge 2 ]]
do
   last_file=$(ls multicoil_val/ | sort -V | tail -n 1)
   echo " gsutil -m cp multicoil_val/$last_file gs://brain_fastmri/ "
   rm multicoil_val/$last_file
   # file_num=$(($file_num - 1))
   file_num=$(ls multicoil_val/ | wc -l)
done
