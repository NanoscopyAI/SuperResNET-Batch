#!/bin/bash
#Submit script with command "sbatch --array=1-$(./easy_submit.sh -a) easy_submit.sh"	


##############################################################################
#                               Fill in                                      #
##############################################################################

#SBATCH --account=acc-name
#SBATCH --mem-per-cpu=32G       #increase as needed
#SBATCH --time=1-0         #hr:min:sec or days-hours or days-hours:minutes
#SBATCH --mail-user=user@address.ca
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE,ALL


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
# You cannot have a space betwen variable and value   #
#                                                     #
#               x=5 CORRECT                           #
#               x= 5, x =5, x = 5 WRONG               #
#                                                     #
#        Strings/text must be in quotations           #
#                                                     #
# Always best to use full paths instead of relative   #
# (eg /home/user/scratch/data ... vs scratch/data/)   #
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#


#Full path for the pipeline folder location
pipline_directory=""

#Parent directory for the data files, will search this recursively,
#no file should be the same name regardless of location
input_directory=""

#Where should the output be saved? Regardless of where they are in the input directory,
#all output files will be saved in the same directory.
#Output file name is unique if filename is unique
#        OR 
#set output_directory="same" to save in the same spot as each input file
output_directory="same"

#Extension of files to be processed
ext=".ascii"


merge_threshold=16
alpha_noise=4
proximity_threshold=80
kernal_bandwidth=120

#Region of interest
min_X=0
max_X=20000

min_Y=0
max_Y=20000

min_Z=-600
max_Z=600

#Unit conversions to nm
# "Data in provided file" * conv = "Data in nm" 
Xconv=99  
Yconv=99
Zconv=1 



##############################################################################
#                               Ignore                                       #
##############################################################################
cd $pipeline_directory


OIFS="$IFS"
IFS=$'\n'  #Make sure loops split on newline not spaces, in case filenames have spaces
paths=(); names=()
for file in $(find $input_directory -name *$ext -type f)
do    
        file="${file//'\'/'/'}" #Make sure slashes are correct

        names+=($(basename $file))
        paths+=($(dirname $(realpath $file))) 
done
IFS="$OIFS"


len=${#names[@]}
if [[ $# -eq 1 ]]
then
        if [[ $1 == "-a" ]] #Return total count of files, to determine cpu count
        then
                echo $len
                exit

        elif [[ $1 == "--test" ]] || [[ $1 == "-t" ]] #Print all files found, to confirm no path issues
        then
                for ((i=0; i<$len; i++))
                do
                        echo ${paths[$i]}'/'${names[$i]}
                done
                exit
        fi
fi

idx=$SLURM_ARRAY_TASK_ID
let idx-=1 #adjust index

path=${paths[$idx]}
name=${names[$idx]} #check 0 indexing
#do not touch the data folder while jobs are queued

module purge
module load matlab/2020a
echo "Running"
matlab -nodesktop -nosplash -r "cd '$pipline_directory'; \
pipeline '$path' '$name' '$output_directory' \
$min_X $max_X $min_Y $max_Y $min_Z $max_Z \
$merge_threshold $alpha_noise \
$proximity_threshold $kernal_bandwidth \
$Xconv $Yconv $Zconv; quit"                                                                                                  
