#bashrc

#Need to decide whether I want to symbolic link everything
#or if I want to simply back up to the git folder.


#Copy Over .vimrc
mv /home/abb62261/Linux-Setup-Files/vimrc /home/abb62261/Linux-Setup-Files/vimrc.bak
cp /home/abb62261/.vimrc /home/abb62261/Linux-Setup-Files/vimrc 

#Copy Over .bashrc
mv /home/abb62261/Linux-Setup-Files/bashrc /home/abb62261/Linux-Setup-Files/bashrc.bak
cp /home/abb62261/.bashrc /home/abb62261/Linux-Setup-Files/bashrc 

#Copy Over .tmux
mv /home/abb62261/Linux-Setup-Files/tmux.conf /home/abb62261/Linux-Setup-Files/tmux.conf.bak
cp /home/abb62261/.tmux.conf /home/abb62261/Linux-Setup-Files/tmux.conf


