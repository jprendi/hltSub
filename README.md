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
```
Ok great, we now here a bit more on where I got all the things from.

