if [ "$HOSTTYPE" == "x86_64" ]
then

../../exe64/syntax -dictdir ../../bin-linux64 -lazy_lexicon -disallow_incomplete -morphology -language autodetect -maxalt 20

else

../../exe/syntax -dictdir ../../bin-linux -lazy_lexicon -disallow_incomplete -morphology -language autodetect -maxalt 20

fi


