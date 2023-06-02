# PANDOC='pandoc'
# CROSSREF='pandoc-crossref'
if [ ! -f "./pandoc" ]; then
    # Download Pandoc/Pandoc-crossref binaries
    curl "https://yongfu.name/deps/pandoc.tar.xz" -O
    tar xf pandoc.tar.xz
fi

# Build LaTeX for overleaf
./pandoc --defaults pandoc-base \
         --defaults pandoc-tex \
         -o main_pandoc.tex --verbose

# xelatex --jobname=thesis main_pandoc.tex
# exit 0

[[ -d docs ]] || mkdir docs
mkdir overleaf
cp -r chapters/figures deps main_pandoc.tex deps/ntuthesis.cls overleaf/
[[ -f ./口試委員審定書.pdf ]] && cp ./口試委員審定書.pdf overleaf/
echo '\input{main_pandoc.tex}' > overleaf/main.tex
zip -r overleaf.zip overleaf
mv overleaf.zip docs/
rm -r overleaf main_pandoc.tex
# cp thesis.pdf docs/  # for publication on GitHub Pages (need manual update)
