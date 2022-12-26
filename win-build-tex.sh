pandoc() {
    ./win-bash/pandoc.exe "$@"
}
pandoc-crossref() {
    ./win-bash/pandoc-crossref.exe "$@"
}
zip() {
    ./win-bash/zip.exe "$@"
}

# Build LaTeX for overleaf
pandoc setup.md chapters/denotations.md deps/mainmatter.md \
    chapters/0*.md deps/references.md chapters/appendix*.md \
    --from markdown+superscript+subscript \
    -s -o main_pandoc.tex \
    -F pandoc-crossref \
    --lua-filter deps/lua/insertTables.lua \
    --lua-filter deps/lua/pandoc-ling.lua \
    --bibliography chapters/references.bib \
    --lua-filter deps/lua/rmCiteSpace.lua \
    --citeproc \
    --lua-filter deps/lua/denotation.lua \
    --lua-filter deps/lua/denotation-item.lua \
    --lua-filter deps/lua/reference-title.lua \
    --lua-filter deps/lua/appendix.lua \
    --template deps/template.tex \
    --top-level-division chapter \
    --csl deps/citation-style.csl

[[ -d docs ]] || mkdir docs
[[ -d overleaf ]] && rm -r overleaf
mkdir overleaf
cp -r chapters/figures deps main_pandoc.tex deps/ntuthesis.cls overleaf/
[[ -f ./口試委員審定書.pdf ]] && cp ./口試委員審定書.pdf overleaf/
echo '\input{main_pandoc.tex}' > overleaf/main.tex
zip -r overleaf.zip overleaf
mv overleaf.zip docs/
# rm -r overleaf main_pandoc.tex
rm main_pandoc.tex
cp thesis.pdf docs/  # for publication on GitHub Pages (need manual update)
