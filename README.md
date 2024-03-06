## SuperResNET Batch 

This repo holds the SuperResNET batch pipeline using V3.0 of SuperResNET designed by Ismail Khater.

Also contains work written by Christian Hallgrimson, Ben Cardoen, & Mona Shahsavari.

For GUI SuperResNET please see: [medicalimageanalysis.com/software/superresnet](https://www.medicalimageanalysis.com/software/superresnet)

### Citation
If you make use of this work, please cite:
```
@Article{KhaterSR2018,
title={Super Resolution Network Analysis Defines the Molecular Architecture of Caveolae and Caveolin-1 Scaffolds},
author={Khater, Ismail M. and Meng, Fanrui and Wong, Timothy H. and Nabi, Ivan Robert and Hamarneh, Ghassan},
journal={Scientific Reports},
year={2018},
url={https://doi.org/10.1038/s41598-018-27216-4}
}
```

### Usage

The pipeline can be run directly on a single file from the commmand line:
```bash
matlab -nodesktop -nosplash -r "pipeline <input_dir/> <file_name/> <output_dir/> \
min_X max_X min_Y max_Y min_Z max_Z \
merge_threshold alpha_noise proximity_threshold kernal_bandwidth \
Xconv Yconv Zconv; quit" 
```

or within matlab:
```
pipeline(input_dir, file_name, output_dir, min_X, max_X, min_Y, max_Y, min_Z, max_Z, merge_threshold, alpha_noise, proximity_threshold, kernal_bandwidth, Xconv, Yconv, Zconv);
```

The file "slurm_submit.sh" provides an easy-to-use script for submitting to a cluster using SLURM, jobs will be submitted across multiple cores (A job per input file). 
Usage instructions and parameters required are explained within the file. It is recommended to create a copy of this file for every experiment. To submit the script you can use the command:

```bash
sbatch --array=1-$(./easy_submit.sh -a) easy_submit.sh
```

### Parameters
**input_dir**: Directory containing the data to process    
**file_name**: File to process. Supports the extensions, .ascii, .bin. txt, .csv, .d3dlp      
**output_dir**: Where to save the results. (Note that the output filename is based on the input filename). Set to "same" to place results in the same location as the input file.        
**min_X, max_X, min_Y, max_Y, min_Z, max_Z**: Region of interest    
**merge_threshold, alpha_noise, proximity_threshold, kernal_bandwidth**: SuperResNET Parameters     
**Xconv, Yconv, Zconv**: Unit conversions to nm. The value should be such that, "Localizations provided" * conv = "Localizations in nm"    


### Grouping 
The SuperResNET grouping functionality is given in the "Grouping/" folder. Fill in the script "Grouping/group.m" as described in the file. It is recommended to create a copy for each experiment. The script can run directly in the command line with:
```bash
matlab -nodesktop -nosplash -r "run(group.m); quit"
```

or within matlab by using the run button with the script open or by using the command:
```
run(group.m)
```


#### Requirements
- Matlab
- Clone of this repo. All dependencies are included.
