jupyter nbconvert pyam-iamc2017.ipynb --to slides --reveal-prefix ../reveal.js
mv pyam-iamc2017.slides.html index.html
sed -i 's/\.\.\/reveal.js/https:\/\/cdnjs\.cloudflare\.com\/ajax\/libs\/reveal\.js\/3\.1\.0/g' index.html 
