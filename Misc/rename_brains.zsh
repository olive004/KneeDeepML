
# generate dummy files
for i in {1..10}
do
   touch multicoil_val/$i.txt
done

for file in $(gsutil ls gs://brain_fastmri/multicoil_val/ | egrep '\.h5')
do
   gsutil mv gs://brain_fastmri/$file gs://brain_fastmri/multicoil_val/$file &&
   echo "moving $file"
done
