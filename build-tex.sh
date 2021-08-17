# PANDOC='pandoc'
# CROSSREF='pandoc-crossref'
if [ ! -f "./pandoc" ]; then
    # Download Pandoc/Pandoc-crossref binaries
    curl https://yongfu.name/deps/pandoc.tar.xz -O
    tar xf pandoc.tar.xz
fi

# Build LaTeX for overleaf
./pandoc setup.md chapters/denotations.md deps/mainmatter.md \
    chapters/0*.md deps/references.md chapters/appendix*.md \
    -s -o main.tex \
    --lua-filter deps/lua/rmCiteSpace.lua \
    -F ./pandoc-crossref \
    --lua-filter deps/lua/insertTables.lua \
    --lua-filter deps/lua/pandoc-ling.lua \
    --bibliography chapters/references.bib \
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
cp -r chapters/figures deps main.tex deps/ntuthesis.cls overleaf/
zip -r overleaf.zip overleaf
mv overleaf.zip docs/
rm -r overleaf main.tex
cp thesis.pdf docs/  # for publish on GitHub Pages (need manual update)
