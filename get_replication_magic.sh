#!/bin/bash

cat - | while read in; do
    chr=$(echo $in | cut -d' ' -f1)
    ps=$(echo $in | cut -d' ' -f2)
    alleles=$(echo $in | cut -d' ' -f3 | tr '/' ' ')
    trait=$(echo $in | cut -d' ' -f4)
    cohort=$(echo $in | cut -d' ' -f5)
    rs=$(echo $in | cut -d' ' -f6)

	rtrait=$(echo $trait | grep G)
	if [ -z $rtrait ]; then
	    ttrait=FI
	else
	    ttrait=FG
    fi


    if [ $cohort == "MANOLIS" ]
    then
	replication=$(LC_ALL=C grep -wf <(awk -F, 'NR>1 && $17>0.7{print "chr"$4":"$2, $6,$7, $17}' /lustre/scratch114/projects/helic/assoc_freeze_Summer2015/output/ldprune_indep_50_5_2.hwe.1e-5/$trait/$chr.$ps.peakdata.ld.annotated.assoc | awk '$NF>0.7' | cut -d' ' -f1-3 | /usr/local/bin/perl /nfs/team144/ds26/tools/CheckVariationSource_SNPID.pl | tail -n +2 | awk '$4=="+"'| cut -f2 | tr ',' '\n') /lustre/scratch114/projects/helic/assoc_freeze_Summer2015/replication/magic/all.$ttrait.merged | tr ',' ' ' | awk 'BEGIN{ORS=" "}{if($5<0.05){a="f1:"$1":"$2","$3","$4","$5} if($7<0.05){b="f1BMI:"$1":"$2","$6","$7} if($11<0.05){c="f2:"$8","$9","$10","$11}if($NF<0.05){d="f4:"$12","$13","$14","$15} print a,b,c,d"\n"}' | tr '\n' ' ')
    echo $chr $ps $replication
    elif [ $cohort == "POMAK"  ]
    then
	replication=$(LC_ALL=C grep -wf <(awk -F, 'NR>1 && $18>0.7{print "chr"$4":"$2, $6,$7, $18}' /lustre/scratch114/projects/helic/assoc_freeze_Summer2015_POMAK/output/ldprune_indep_50_5_2.hwe.1e-5/$trait/$chr.$ps.peakdata.ld.annotated.assoc | awk '$NF>0.7' | cut -d' ' -f1-3 | /usr/local/bin/perl /nfs/team144/ds26/tools/CheckVariationSource_SNPID.pl | tail -n +2 | awk '$4=="+"'| cut -f2 | tr ',' '\n') /lustre/scratch114/projects/helic/assoc_freeze_Summer2015/replication/magic/all.$ttrait.merged | tr ',' ' ' | awk 'BEGIN{ORS=" "}{if($5<0.05){a="f1:"$1":"$2","$3","$4","$5} if($7<0.05){b="f1BMI:"$1":"$2","$6","$7} if($11<0.05){c="f2:"$8","$9","$10","$11}if($NF<0.05){d="f4:"$12","$13","$14","$15} print a,b,c,d"\n"}' | tr '\n' ' ')
    echo $chr $ps $replication
    else
	echo $chr $ps meta
    fi
    


done
