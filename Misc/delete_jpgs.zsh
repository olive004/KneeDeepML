#!/bin/bash

# EXT=jpg
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/24m/3.E.1/)
# do
#     for folder in $(gsutil ls $parent_folder)
#     do
#         for file in $(gsutil ls $folder)
#         do
#             if [ "${file}" != "${file%.${EXT}}" ];then
#                 echo $file && gsutil rm $file
#             fi
#             # basename -s .tar.gz $file
#         done
        
#     done
# done

# instead of checking file by file 
EXT=jpg
for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/24m/3.E.1/)
do
    for folder in $(gsutil ls $parent_folder)
    do
        for file in $(gsutil ls $folder)
        do
            if [ "${file}" != "${file%.${EXT}}" ];then
                echo $file && gsutil rm $file
            fi
            # basename -s .tar.gz $file
        done
        
    done
done