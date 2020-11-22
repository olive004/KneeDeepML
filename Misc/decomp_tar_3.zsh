#!/bin/bash
# gsutil ls gs://oai_baseline_and_12months/00m/0.E.1/ > ls_00e.txt
# gsutil ls gs://oai_baseline_and_12months/00m/0.C.2/ > ls_00c.txt
# gsutil ls gs://oai_baseline_and_12months/12m/1.E.1/ > ls_12e.txt
# gsutil ls gs://oai_baseline_and_12months/00m/0.C.2/ > ls_00c.txt
# gsutil ls gs://oai_baseline_and_12months/18m/2.D.2 > ls_18d.txt
# gsutil ls gs://oai_baseline_and_12months/24m/3.C.2 > ls_24c.txt
# gsutil ls gs://oai_baseline_and_12months/24m/3.E.1 > ls_24e.txt
# gsutil ls gs://oai_baseline_and_12months/30m/4.G.1 > ls_30g.txt
# gsutil ls gs://oai_baseline_and_12months/36m/5.C.1 > ls_36c.txt
# gsutil ls gs://oai_baseline_and_12months/36m/5.E.1 > ls_36e.txt
# gsutil ls gs://oai_baseline_and_12months/48m/6.C.1 > ls_48c1.txt
# gsutil ls gs://oai_baseline_and_12months/48m/6.E.1 > ls_48e1.txt
# gsutil ls gs://oai_baseline_and_12months/48m/6.E.2 > ls_48e2.txt
# gsutil ls gs://oai_baseline_and_12months/72m/8.C.1 > ls_72c.txt
# gsutil ls gs://oai_baseline_and_12months/72m/8.E.1 > ls_72e.txt
# gsutil ls gs://oai_baseline_and_12months/96m/10.C.1 > ls_96c.txt


EXT=tar.gz
tot_sofar=0
thresh_l=1000
thresh_g=1200
# gsutil ls gs://oai_baseline_and_12months/96m/10.E.1 > ls_96e.txt
total=$(wc -l ls_96e.txt)
while read parent_folder; do
    tot_sofar=$((tot_sofar + 1))
    echo "$tot_sofar / $total"
    if [ "${tot_sofar}" -lt "${thresh_l}" ];then
        echo "skip less ${tot_sofar}"
        continue
    fi
    if [ "${tot_sofar}" -gt "${thresh_g}" ];then
        echo "skip greater ${tot_sofar}"
        continue
    fi
    for folder in $(gsutil ls $parent_folder)
    do
        # Check if a subdirectory has been made
        last_folder=$(gsutil ls $folder | tail -1)
        if [ "${last_folder: -2}" == "//" ];then
            "found a //"
            break
        fi
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
done <ls_96e.txt
