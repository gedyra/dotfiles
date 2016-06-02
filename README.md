# dotfiles
## これなに
"~/.hoobar"をいいかんじにする

##使い方
vimrcとかdotfilesLink.shにあるファイルがないことを仮定している
```bash
$ cd ~/
$ git clone https://github.com/gedyra/dotfiles.git
$ sh dotfilesLink.sh
```
## ファイルが追加されたとき
```bash
$ cd ~/dotfiles

#初めて使うとき 
#$ git add .
#$ git commit -m 'COMMENT'
#$ git remote add origin git@github.com/gedyra/dotfiles.git

$ git push origin master  
```

## 同期
```bash
$ git pull
```
