# hltSub
## get what you need
Get the basics down, make sure you are in your afs area:
```
cmsrel CMSSW_14_2_2
scram project -n hltSubLC CMSSW_14_2_2
voms-proxy-init --voms cms --valid 168:00
```
The last one will give an output like "Created proxy in /tmp/nameOfFile". Copy the the name of the file after tmp, according to what you get.
```
cd hltSubLC/src
cp -pr /tmp/nameOfFile .
git clone git@github.com:jprendi/hltSub.git
cd hltSub
cmsenv
./getLCconfig.sh
```
Ok great, we now here a bit more on where I got all the things from. The last command will run the 'hltGetConfiguration' command, which will give us the config file that uses HLT tag but will use the prompt laser correction record. Please note that the input is given as ` '  ' ` because we need a huge list of input files and putting them into this shell file will give you a complaint that the line is too long.
Now onto the filelist, we want to get all the files within `Run2024I/EGamma1/RAW-RECO/`, so we will run:
```
dasgoclient -query='file site=T2_CH_CERN dataset=/EGamma1/Run2024I-ZElectron-PromptReco-v1/RAW-RECO' >& fileList.txt 
```


```
python3 cmsCondorDataFiles.py dumpLC.py /afs/cern.ch/user/j/jprendi/CMSSW_14_2_2/src/ /eos/cms/store/group/tsg-phase2/user/jprendi/lcStudies_output -p /afs/cern.ch/user/j/jprendi/hltSubLC/src/x509up_u167055 -q testmatch -n 20


condor_submit condor_cluster.sub
```
And if you want to check your stuff, see: `condor_q`

