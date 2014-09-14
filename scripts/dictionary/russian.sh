# The script builds the Russian dictionary (lexicon)
# More info about dictionary compilation:
# http://solarix.ru/for_developers/bootstrap/compile_dictionary.shtml

./cleanup.sh

set -e

if [ "$OSTYPE" == "darwin10.0" ]
then

echo "Starting compilation under DARWIN..."
../../exemac/compiler -j=2 -optimize -dir=../../dictionary.src -outdir=../../bin-mac -ldsize=2000000 -save_paradigmas -save_seeker -save_affixes -save_lemmatizer -save_prefix_entry_searcher ../../dictionary.src/version-pro ../../dictionary.src/dictionary -file=../../dictionary.src/russian-language-only.sol ../../dictionary.src/shared-resources ../../dictionary.src/russian-lexicon ../../dictionary.src/russian-stat ../../dictionary.src/russian-thesaurus ../../dictionary.src/lemm_model.files ../../dictionary.src/common-syntax ../../dictionary.src/russian-syntax ../../dictionary.src/dictionary-russian ../../dictionary.src/common_dictionary_xml
 
else

 if [ "$HOSTTYPE" == "x86_64" ]
 then
 
 ../../exe64/compiler -j=2 -optimize -dir=../../dictionary.src -outdir=../../bin-linux64 -ldsize=2000000 -save_paradigmas -save_seeker -save_affixes -save_lemmatizer -save_prefix_entry_searcher ../../dictionary.src/version-pro ../../dictionary.src/dictionary -file=../../dictionary.src/russian-language-only.sol ../../dictionary.src/shared-resources ../../dictionary.src/russian-lexicon ../../dictionary.src/russian-stat ../../dictionary.src/russian-thesaurus ../../dictionary.src/lemm_model.files ../../dictionary.src/common-syntax ../../dictionary.src/russian-syntax ../../dictionary.src/dictionary-russian ../../dictionary.src/common_dictionary_xml
 
 cp ../../bin-linux64/affixes.bin              ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/alphabet.bin             ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/diction.bin              ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/seeker.bin               ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/lexicon.db               ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/thesaurus.db             ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/prefix_entry_searcher.db ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/lemmatizer.db            ../../distributives/Dictionary/pro/linux64/ru
 cp ../../bin-linux64/dictionary.xml           ../../distributives/Dictionary/pro/linux64/ru
 
 else
 
 ../../exe/compiler -j=2 -optimize -dir=../../dictionary.src -outdir=../../bin-linux -ldsize=2000000 -save_paradigmas -save_seeker -save_affixes -save_lemmatizer -save_prefix_entry_searcher ../../dictionary.src/version-pro ../../dictionary.src/dictionary -file=../../dictionary.src/russian-language-only.sol ../../dictionary.src/shared-resources ../../dictionary.src/russian-lexicon ../../dictionary.src/russian-stat ../../dictionary.src/russian-thesaurus ../../dictionary.src/lemm_model.files ../../dictionary.src/common-syntax ../../dictionary.src/russian-syntax ../../dictionary.src/dictionary-russian ../../dictionary.src/common_dictionary_xml
 
 cp ../../bin-linux/affixes.bin              ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/alphabet.bin             ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/diction.bin              ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/seeker.bin               ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/lexicon.db               ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/thesaurus.db             ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/prefix_entry_searcher.db ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/lemmatizer.db            ../../distributives/Dictionary/pro/linux/ru
 cp ../../bin-linux/dictionary.xml           ../../distributives/Dictionary/pro/linux/ru
 
 fi

fi
