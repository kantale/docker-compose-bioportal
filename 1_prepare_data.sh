#!/bin/bash

function syntax {
	echo "Usage: prepare_image.sh PORTAL APIKEY ONTOLOGIES"
	echo "PORTAL = (lirmm|ncbo), ONTOLOGIES=ACRONYM1,ACRONYM2,ACRONYM3,[...]"
	exit 1
}

if [ "$#" -ne 3 ]; then
	syntax
fi

PORTAL=$1
APIKEY=$2
ONTOLOGIES=$(echo $3 | sed "s/,/ /g")

if [ "$PORTAL" != "lirmm" ] && [ "$PORTAL" != "ncbo" ]; then
	syntax
fi

if [ "$PORTAL" == "lirmm" ]; then
	echo "(French) LIRMM Bioportal selected"
	URL="http://data.bioportal.lirmm.fr"
elif [ "$PORTAL" == "ncbo" ]; then 
	echo "(English) NCBO Portal selected"
	URL="http://data.bioontology.org"
fi

for ACRONYM in $ONTOLOGIES
do
	echo "Processing $ACRONYM"
	SUBURL="$URL/ontologies/$ACRONYM/submissions?apikey=$APIKEY"
	NUMSUB=`curl $SUBURL 2> /dev/null | jq "length"`
	echo -e "\tFound $NUMSUB submissions, retrieving latest..."
	if [ "$NUMSUB" -ne "0" ]; then
		DOWNLOADURL="$URL/ontologies/$ACRONYM/submissions/$NUMSUB/download?apikey=$APIKEY"
		STATUS=$(curl -I "$URL/ontologies/$ACRONYM/submissions/$NUMSUB/download?apikey=$APIKEY" 2>/dev/null | grep HTTP | cut -d' ' -f2)
	        echo -e "\t=>Status $STATUS [OK]"	
		if [ "$STATUS" == "200" ]; then
			wget $DOWNLOADURL -q -O data/bioportal/repository/$ACRONYM.ttl
		elif [ "$STATUS" == "403" ]; then 
			echo -e "\tWARNING: Licensing restrictions for $ACRONYM prevent the download..."
		elif [ "$STATUS" == "404" -o "$STATUS" == "500" ]; then
			echo -e "\tWARNING: The $ACRONYM ontology does not exist in the selected bioportal"
		fi
	fi
done
