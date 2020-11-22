#!/bin/bash

# For decompressing everything in the folders before x folder

$(gsutil ls gs://oai_baseline_and_12months/00m/0.C.2/9000296/20040909/*.{tar.gz})

EXT=tar.gz
# total=$(gsutil ls gs://oai_baseline_and_12months/48m/6.E.2/ | wc -l)
total=$(gsutil ls gs://oai_baseline_and_12months/96m/10.E.1/ | wc -l)
tot_sofar=0
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/48m/6.E.2/)
for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/96m/10.E.1/)
do
    tot_sofar=$((tot_sofar + 1))
    echo "$tot_sofar / $total"
    for folder in $(gsutil ls $parent_folder)
    do
        for file in $(gsutil ls $folder*.tar.gz)
        do
            cd && echo "$tot_sofar / $total"
            echo $file
            # file base names 
            new_folder=$(basename -s .tar.gz $file)
            filename=$(basename $file)
            # new dir
            mkdir temp_tar_files/$new_folder
            gsutil cp $file ./temp_tar_files/$filename
            # decompress
            cd temp_tar_files/$new_folder 
            tar -xzvf ../$filename
            cd
            cd temp_tar_files 
            echo $folder/$new_folder
            gsutil -m cp -r $new_folder $folder/$new_folder && cd && rm ./temp_tar_files/$filename && rm -r ./temp_tar_files/$new_folder
        done
    done
done
