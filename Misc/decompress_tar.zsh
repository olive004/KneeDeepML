#!/bin/bash

# For decompressing tar files that are already in the bucket using a vm


# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/12m/1.C.2/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/12m/1.E.1/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/00m/0.C.2/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/00m/0.E.1/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/18m/2.D.2/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/24m/3.E.1/)
# for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/30m/4.G.1/)
EXT=tar.gz
for parent_folder in $(gsutil ls gs://oai_baseline_and_12months/36m/5.C.1/)
do
    for folder in $(gsutil ls $parent_folder)
    do
        for file in $(gsutil ls $folder)
        do
            if [ "${file}" != "${file%.${EXT}}" ];then
                cd && echo $(pwd)
                echo $file
                # file base names 
                new_folder=$(basename -s .tar.gz $file)
                filename=$(basename $file)
                # new dir
                mkdir temp_tar_files/$new_folder
                gsutil cp $file ./temp_tar_files/$filename
                echo $(ls temp_tar_files)
                # decompress
                cd temp_tar_files/$new_folder && echo $(pwd)
                tar -xzvf ../$filename
                cd
                cd temp_tar_files && echo $(pwd)
                echo $folder/$new_folder
                gsutil -m cp -r $new_folder $folder/$new_folder && cd && rm ./temp_tar_files/$filename && rm -r ./temp_tar_files/$new_folder
            fi
        done
    done
done

