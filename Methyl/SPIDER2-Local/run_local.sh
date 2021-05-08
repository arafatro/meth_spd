#!/bin/bash

# the blastpgp and NR database
blastpgp=/usr/local/blast2.2.25/bin/blastpgp
NR=/scratch1/NR/nr

########
xdir=$(dirname $0)
hse_dir=$xdir/HSE

if [ $# -lt 1 ]; then
	echo "usage: $0 *"
	echo "   required: pro1.seq or pro1.pssm"
	exit 1
fi

for seq1 in $*; do
	pro1=$(basename $(basename $seq1 .seq) .pssm)
	if [ ! -f $pro1.pssm ]; then
		$blastpgp -d $NR -j 3 -b 1 -a 16 -i $pro1.seq -Q $pro1.pssm > /dev/null
	fi

	$xdir/run_pssm.py $pro1.pssm
	$hse_dir/run1.sh ./ $pro1.spd3
done

