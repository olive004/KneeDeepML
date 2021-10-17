while read file
do
   f="$(basename -- $file)"
   mv multicoil_train/$f multicoil_train_zero/$f && echo $f
done <small_train_files.txt
