# hltSub
## get what you need
Get the basics down, make sure you are in your afs area:
```
voms-proxy-init --voms cms --valid 168:00
scram project -n LCtimeseries CMSSW_15_0_6
```
The last one will give an output like "Created proxy in /tmp/nameOfFile". Copy the the name of the file after tmp, according to what you get.
```
cd LCtimeseries/src/
cp -pr /tmp/x509up_uNXYZ .

git clone git@github.com:jprendi/hltSub.git
cd hltSub/
cmsenv
./getLCconfig.sh
grep '/000/386/509/' fileList.txt > fileList_509.txt
```

```
python3 cmsCondorDataFiles.py dumpLC.py /afs/cern.ch/user/j/jprendi/LCtimeseries/src/ /eos/cms/store/group/tsg-phase2/user/jprendi/PrLC_Run2024I_386509 -p /afs/cern.ch/user/j/jprendi/LCtimeseries/src/x509up_uNXYZ -q testmatch -n 1


condor_submit condor_cluster.sub
```
And if you want to check your stuff, see: `condor_q`

extra:
Ok great, we now here a bit more on where I got all the things from. The last command will run the 'hltGetConfiguration' command, which will give us the config file that uses HLT tag but will use the prompt laser correction record. Please note that the input is given as ` '  ' ` because we need a huge list of input files and putting them into this shell file will give you a complaint that the line is too long.
Now onto the filelist, we want to get all the files within `Run2024I/EGamma1/RAW-RECO/`, so we will run:
```
dasgoclient -query='file site=T2_CH_CERN dataset=/EGamma1/Run2024I-ZElectron-PromptReco-v1/RAW-RECO' >& fileList.txt 
```
