#!/bin/bash
# Usage : ./test.sh nom_du_programme   (sans l'extension)
prog="$1"
CC="$HOME/cobolcheck"
[ -z "$prog" ] && { echo "Usage : ./test.sh nom_du_programme"; exit 1; }

src=$(find . -path ./tests -prune -o -type f \( -name "$prog.cob" -o -name "$prog.cbl" -o -name "$prog.COB" -o -name "$prog.CBL" \) -print | head -1)
[ -z "$src" ] && { echo "Source $prog.cob introuvable"; exit 1; }
[ -d "tests/$prog" ] || { echo "Dossier tests/$prog manquant"; exit 1; }

mkdir -p "$CC/src/test/cobol/$prog"
rm -f "$CC/src/test/cobol/$prog/"*.cut
cp "$src" "$CC/src/main/cobol/"
cp "tests/$prog/"*.cut "$CC/src/test/cobol/$prog/"

(cd "$CC" && java -jar bin/cobol-check-0.2.19.jar -p "$prog")
grep -qE '^[[:space:]]*0 FAILED' "$CC/testruns/testResults.txt"
