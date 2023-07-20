#!/bin/bash

curl "https://zenodo.org/record/7348355/files/interactions.tsv.gz" > ../results/interactions.tsv.gz
cat ../results/interactions.tsv.gz | gunzip | egrep "RO_0002622|RO_0002455" | wc -l
elton update --cache-dir=../results/elton/datasets --work-dir=../results/elton/ `(cat ../results/interactions.tsv.gz | gunzip | egrep "RO_0002622|RO_0002455" | cut -f89 | uniq | sort | uniq)`

FILES=()
for f in $(find ../results/elton -type f); do
    FMT=$(file $f | cut -d" " -f2)
    if [[ $FMT == "JSON" ]]
    then
        cat $f | jq --arg file "$f" -r 'try ([."@context"?[0],.format//"NULL",(.tables[0]?.delimiter)//"NULL",.url//"NULL",.citaton//"NULL",$file] | @tsv)'
    fi
done