#!/bin/bash

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
echo "[Desktop Entry]" > ~/Desktop/start_collection.desktop
echo "Version=1.1" >> ~/Desktop/start_collection.desktop
echo "Name=start_collection" >> ~/Desktop/start_collection.desktop
echo "Comment=only for data collection" >> ~/Desktop/start_collection.desktop
echo "Exec= bash -c 'python ~/octopus-docker/octopus_docker_launcher.py --tag develop-1172 --auto && sleep 8 && google-chrome http://localhost:8080'" >> ~/Desktop/start_collection.desktop
echo "Icon=$HOME/.icons/start-button.jpg" >> ~/Desktop/start_collection.desktop
echo "Terminal=false" >> ~/Desktop/start_collection.desktop
echo "Type=Application" >> ~/Desktop/start_collection.desktop
echo "Categories=Utility;Application;" >> ~/Desktop/start_collection.desktop
echo "[Desktop Entry]" > ~/Desktop/stop_collection.desktop
echo "Version=1.1" >> ~/Desktop/stop_collection.desktop
echo "Name=stop_collection" >> ~/Desktop/stop_collection.desktop
echo "Comment=only for data collection" >> ~/Desktop/stop_collection.desktop
echo "Exec= bash -c 'python ~/octopus-docker/octopus_docker_launcher.py --tag develop-1172 --clear'" >> ~/Desktop/stop_collection.desktop
echo "Icon=$HOME/.icons/stop-button.jpg" >> ~/Desktop/stop_collection.desktop
echo "Terminal=false" >> ~/Desktop/stop_collection.desktop
echo "Type=Application" >> ~/Desktop/stop_collection.desktop
echo "Categories=Utility;Application;" >> ~/Desktop/stop_collection.desktop

# permission fix
sudo chmod a+x ~/Desktop/start_collection.desktop ~/Desktop/stop_collection.desktop
echo "Setup done!"
