#!/usr/bin/env bash
cd work

# collecct the positions all dxy outputs
# (this will contain completed 1st runs
# and reruns after timeout of the 1st runs)
# delete files with a size of 0 bytes
ls -lt ./*/*/*50kb-5kb.txt.gz | \
 awk '{print $5"\t"$9}' | \
 sed 's=\t./=\t=g' | \
 awk '$1>0{print}' > ../dxy_tab_content.txt

cd ..

# create output directories
mkdir -p out/dxy/lg
mkdir -p out/dxy/all

# copy all dxy outputs from their directory within ./work
# into the ./out directory
# while doing so, rename duplicated entries (append ".2")
while read p; do
  echo -e "$p \n -----------"
	q=$(echo $p | awk '{print $2}')
	w=$(echo $q |  sed 's=.*/==g')
	if [ -f out/dxy/lg/$w ]
	then
    	    w=$w".2"
	fi
	cp work/$q out/dxy/lg/$w
done < dxy_tab_content.txt

cd out/dxy/lg

# merge the results from all LGs into a single file per species comparison
for k in gem-may gem-nig gem-pue gem-uni may-nig may-pue may-uni nig-pue nig-uni pue-uni;do
echo " --- $k --- "
# copy header from first file
zcat dxy.$k.LG01.50kb-5kb.txt.gz | head -n 1 > dxy.$k.all.50kb-5kb.txt
# loop over LGs and append the content without the header
for j in {01..24};do
zcat dxy.$k.LG$j.50kb-5kb.txt.gz | tail -n +2 >> dxy.$k.all.50kb-5kb.txt
done
# compress and move to final output directory
gzip dxy.$k.all.50kb-5kb.txt
mv dxy.$k.all.50kb-5kb.txt.gz ../all
done

