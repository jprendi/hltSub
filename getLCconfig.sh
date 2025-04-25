#!/bin/bash -ex

    hltGetConfiguration /dev/CMSSW_14_1_0/GRun \
       --globaltag 141X_dataRun3_HLT_v2 \
       --data \
       --unprescale \
       --output minimal \
       --max-events -1 \
       --eras Run3_2024 --l1-emulator uGT --l1 L1Menu_Collisions2024_v1_3_0_xml \
        --input " " \
       > hltDataLC.py


cat <<@EOF >> hltDataLC.py

process.GlobalTag.toGet = cms.VPSet(
  cms.PSet(record = cms.string("EcalLaserAPDPNRatiosRcd"),
           tag = cms.string("EcalLaserAPDPNRatios_prompt_v3"),
           connect = cms.string("frontier://FrontierProd/CMS_CONDITIONS")
          )
)

process.hltOutputMinimal.outputCommands = [
    'drop *',
    'keep GlobalObjectMapRecord_hltGtStage2ObjectMap_*_HLTX',
    'keep edmTriggerResults_*_*_HLTX',
    'keep triggerTriggerEvent_*_*_HLTX' 
]

@EOF

edmConfigDump hltDataLC.py > dumpLC.py

