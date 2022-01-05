# PANDOC='pandoc'
# CROSSREF='pandoc-crossref'
if [ ! -f "./pandoc" ]; then
    # Download Pandoc/Pandoc-crossref binaries
    curl "https://yongfu.name/deps/pandoc.tar.xz" -O
    tar xf pandoc.tar.xz
fi


IN="002-test.md"
OUT=${IN/%md/html}
# Get Chapter number
# arrIN=(${IN//-/ })
# let "CHAP=10#${arrIN[0]}"
# OFFSET=$(( $CHAP - 1 ))
# pandoc $IN -o appendix-A.html \
#   --template chapter.html5


# Pass chapter toc to tocChapTmp.html
printf "index.html__" > chapter_index.txt
for IN in chapters/*.md; do
    if [[ $(basename $IN) == 'denotations.md' ]]; then
        continue
    fi
    OUT=${IN/%md/html}
    fname=$(basename $OUT)
    printf "${fname}__" >> chapter_index.txt
done
chaptoc=$(cat chapter_index.txt)
tocChaptmp=$(<deps/tocChap.html)
echo "${tocChaptmp//ANCHOR.TOCCHAP/$chaptoc}" > "tocChapTmp.html"

# Build index page
./pandoc setup.md chapters/denotations.md -o docs/index.html \
    --template deps/main.html5 \
    -H deps/style.html \
    -A tocChapTmp.html \
    -A deps/after-body.html \
    --mathjax

# Build chapters
for IN in chapters/*.md; do
    fname=$(basename $IN)
    if [[ "$fname" == 'denotations.md' ]]; then
        continue
    fi
    
    OUT=${IN/%md/html}
    fname=$(basename $OUT)
    ./pandoc setup.md $IN -o docs/$fname \
        --template deps/chapter.html5 \
        -H deps/style.html \
        -A tocChapTmp.html \
        -A deps/after-body.html \
        --lua-filter deps/lua/rmCiteSpace.lua \
        -F ./pandoc-crossref \
        --lua-filter deps/lua/insertTables.lua \
        --lua-filter deps/lua/pandoc-ling.lua \
        --lua-filter deps/lua/reference-title.lua \
        --bibliography chapters/references.bib \
        --citeproc \
        --csl deps/citation-style.csl \
        --mathjax
done

# Move files
[[ -d docs ]] || mkdir docs
# mv chapters/*.html docs/
cp -r chapters/figures docs/
touch docs/custom.css

# Clean up
rm tocChapTmp.html chapter_index.txt
