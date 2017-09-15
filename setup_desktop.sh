#!/bin/bash
#created by Fuheng on 9/16/2017
shopt -s xpg_echo

# check internet connection
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    echo "Online..."
else
    echo "Offline, please make sure there is internet connection before setup..." && exit 1
fi

# check if octopus-docker
if [ ! -d $HOME/octopus-docker ]; then
    echo "octopus docker doesn't exit in home...going to git clone..." 
    cd ~/ && git clone git@github.com:TuSimple/octopus-docker.git
else
    echo "octopus docker exits...skip git clone..."
fi

# download images
echo "start downloading desktop images..."
if [ ! -d $HOME/.icons ]; then
    mkdir $HOME/.icons
fi
rm -f ~/.icons/start-button.jpg ~/.icons/stop-button.jpg
wget -O ~/.icons/start-button.jpg https://previews.123rf.com/images/johan2011/johan20111106/johan2011110600102/9708256-Button-for-Start-Green-Start-Button-Stock-Photo-push.jpg 
wget -O ~/.icons/stop-button.jpg http://blog.powerdnn.com/wp-content/uploads/2012/12/Stop-Button.jpg
sleep 2

# create destop files
echo "creating desktop files..."
rm -rf ~/Desktop/start_collection.desktop ~/Desktop/stop_collection.desktop
echo "[Desktop Entry]\nVersion=1.1\nName=start_collection\nComment=only for data collection\nExec= bash -c 'python ~/octopus-docker/octopus_docker_launcher.py --tag develop-1172 --auto && sleep 8 && google-chrome http://localhost:8080'\nIcon=$HOME/.icons/start-button.jpg\nTerminal=false\nType=Application\nCategories=Utility;Application;" > $HOME/Desktop/start_collection.desktop
echo "[Desktop Entry]\nVersion=1.1\nName=stop_collection\nComment=only for data collection\nExec= bash -c 'python ~/octopus-docker/octopus_docker_launcher.py --tag develop-1172 --clear'\nIcon=$HOME/.icons/stop-button.jpg\nTerminal=false\nType=Application\nCategories=Utility;Application;" > $HOME/Desktop/stop_collection.desktop


# permission fix
sudo chmod a+x ~/Desktop/start_collection.desktop ~/Desktop/stop_collection.desktop
echo "Setup done!"
