cd ../poster
quarto render 002.qmd
cp 002.html ../../../q/germanic/001/postera0.html
node render-pdf.mjs
cp poster_A0.pdf ../../../q/germanic/001/16838_HA_stschwarz-posterA0.pdf
cp poster_A0.pdf ../../../q/germanic/001/poster_A0.pdf
echo "render, copy finished..."