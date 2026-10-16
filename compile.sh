#!/bin/bash
# Vérifie que tous les programmes COBOL du dépôt compilent.
# - Aucune exécution, aucun exécutable créé (-fsyntax-only)
# - Essaie le format fixe, puis le format libre
# - Les fichiers listés dans .cobolignore (un chemin par ligne,
#   ex. : notions/brouillon.cob) sont ignorés
# Usage : ./compile.sh

ok=0; ko=0; ignores=0

while IFS= read -r f; do
  f="${f#./}"

  if [ -f .cobolignore ] && grep -qxF "$f" .cobolignore; then
    echo "IGNORE  $f"
    ignores=$((ignores+1))
    continue
  fi

  dir=$(dirname "$f")
  if cobc -fsyntax-only -I "$dir" "$f" 2>/dev/null; then
    echo "OK      $f (format fixe)"
    ok=$((ok+1))
  elif cobc -fsyntax-only -free -I "$dir" "$f" 2>/dev/null; then
    echo "OK      $f (format libre)"
    ok=$((ok+1))
  else
    echo "ERREUR  $f"
    echo "        --- en format fixe :"
    cobc -fsyntax-only -I "$dir" "$f" 2>&1 | head -5 | sed 's/^/        /'
    echo "        --- en format libre :"
    cobc -fsyntax-only -free -I "$dir" "$f" 2>&1 | head -5 | sed 's/^/        /'
    [ -n "$GITHUB_ACTIONS" ] && echo "::error file=$f::Le programme ne compile pas"
    ko=$((ko+1))
  fi
done < <(find . -path ./tests -prune -o -path ./.git -prune -o -type f \
          \( -iname "*.cob" -o -iname "*.cbl" \) -print | sort)

echo
echo "Resultat : $ok OK, $ko en erreur, $ignores ignore(s)"

if [ -n "$GITHUB_STEP_SUMMARY" ]; then
  {
    echo "### Compilation"
    echo "- $ok OK"
    echo "- $ko en erreur"
    echo "- $ignores ignore(s)"
  } >> "$GITHUB_STEP_SUMMARY"
fi

[ "$ko" -eq 0 ]