# PANDOC='pandoc'
# CROSSREF='pandoc-crossref'
# if [ ! -f "./pandoc" ]; then
#     # Download Pandoc/Pandoc-crossref binaries
#     curl https://yongfu.name/deps/pandoc.tar.xz -O
#     tar xf pandoc.tar.xz
# fi

# pandoc setup.md chapters/denotations.md deps/mainmatter.md \
#     chapters/0*.md deps/references.md chapters/appendix*.md \
#     --lua-filter deps/lua/appendix.lua \
#     -s -o info.json

# Build LaTeX for overleaf
pandoc setup.md chapters/denotations.md deps/mainmatter.md \
    chapters/0*.md deps/references.md chapters/appendix*.md \
    -s -o info.html \
    --number-sections \
    --toc \
    --from markdown+superscript+subscript \
    -F pandoc-crossref \
    --bibliography chapters/references.yaml \
    --citeproc \
    --lua-filter deps/lua/denotation.lua \
    --lua-filter deps/lua/denotation-item.lua \
    --lua-filter deps/lua/reference-title.lua \
    --lua-filter deps/lua/appendix.lua \
    --top-level-division chapter \
    -H deps/style.html \
    --template deps/info.html5 \
    --csl deps/citation-style.csl
