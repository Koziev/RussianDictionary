if [ "$HOSTTYPE" == "x86_64" ]
then

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
../../exe64/syntax -dictdir ../../bin-linux64 -lazy_lexicon -disallow_incomplete -syntax -maxalt 20

else

../../exe/syntax -dictdir ../../bin-linux -lazy_lexicon -disallow_incomplete -syntax -maxalt 20

fi
