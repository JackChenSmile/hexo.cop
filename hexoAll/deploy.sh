hexo generate
xcopy public /s .deploy/JackChenSmile.github.io
cd .deploy/JackChenSmile.github.io
git add .
git commit -m "update"
git push origin master