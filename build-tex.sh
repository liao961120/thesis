# PANDOC='pandoc'
# CROSSREF='pandoc-crossref'
if [ ! -f "./pandoc" ]; then
    # Download Pandoc/Pandoc-crossref binaries
    curl "https://yongfu.name/deps/pandoc.tar.xz" -O
    tar xf pandoc.tar.xz
fi

# Build LaTeX for overleaf
./pandoc setup.md chapters/denotations.md deps/mainmatter.md \
    chapters/0*.md deps/references.md chapters/appendix*.md \
    --from markdown+superscript+subscript \
    -s -o main_pandoc.tex \
    -F ./pandoc-crossref \
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
mkdir overleaf
cp -r chapters/figures deps main_pandoc.tex deps/ntuthesis.cls overleaf/
echo '\input{main_pandoc.tex}' > overleaf/main.tex
zip -r overleaf.zip overleaf
mv overleaf.zip docs/
rm -r overleaf main_pandoc.tex
# cp thesis.pdf docs/  # for publication on GitHub Pages (need manual update)
