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
	printf "\e[1m (French) LIRMM Bioportal selected\n \e[21m"
	URL="http://data.bioportal.lirmm.fr"
elif [ "$PORTAL" == "ncbo" ]; then 
	printf "\e[1m (English) NCBO Portal selected\n \e[21m"
	URL="http://data.bioontology.org"
fi

mkdir -p data/bioportal/repository/

for ACRONYM in $ONTOLOGIES
do
	printf "\tRetrieving \e[1m $ACRONYM... \e[21m"
	SUBURL="$URL/ontologies/$ACRONYM/submissions?apikey=$APIKEY"
	NUMSUB=`curl $SUBURL 2> /dev/null | jq "length"`
	if [ "$NUMSUB" -ne "0" ]; then
		DOWNLOADURL="$URL/ontologies/$ACRONYM/submissions/$NUMSUB/download?apikey=$APIKEY"
		STATUS=$(curl -I "$URL/ontologies/$ACRONYM/submissions/$NUMSUB/download?apikey=$APIKEY" 2>/dev/null | grep HTTP | cut -d' ' -f2)
		if [ "$STATUS" == "200" ]; then
			wget -c $DOWNLOADURL -q -O data/bioportal/repository/$ACRONYM.ttl
			printf "\e[1m \e[32m [OK]\n \e[0m"
		elif [ "$STATUS" == "403" ]; then 
			printf "\e[91m [FAIL]\n\t \e[0m Licensing restrictions for $ACRONYM prevent the download...\n"
		elif [ "$STATUS" == "404" -o "$STATUS" == "500" ]; then
			printf "\e[91m [FAIL]\n\t \e[0m The $ACRONYM ontology does not exist in the selected bioportal\n"			
		fi
	fi
done
printf "\e[1m Done! \e[0m \n"
