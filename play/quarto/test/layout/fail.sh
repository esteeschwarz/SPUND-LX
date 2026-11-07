rm -rf ~/Library/Caches/quarto
rm -rf ../.quarto _freeze
quarto check # fails on sass dep

# brew install sass/sass/sass
# #f
# brew tap dart-lang/dart
# # no
# sudo port install sassc
# echo "$(which sassc)"
# export QUARTO_DART_SASS=$(which sassc)
# quarto render _kable.qmd

# macos 12.7.6: only wks wt quarto 1.9.38, else dependency error
<https://github.com/quarto-dev/quarto-cli/releases?page=3#release-v1.9.38>
<https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.38/quarto-1.9.38-macos.pkg>