clear
echo "Tagbin Services Pvt Ltd"
echo "Run the command as ci.bash http://bitbucket.org/repo.git root"

#######################################
# Check if GIT REPO is passed as params
#######################################
if [ -z "$1" ] 
then
echo "$(tput setaf 1)No GIT REPO Provided$(tput sgr0)"
exit 0
fi 

###############################
# Check is username is provided
###############################
if [-z "$2" ]
then
echo "$(tput setaf 1)No User provided$(tput sgr0)"
exit 0
fi
ret=false
getent passwd $2 >/dev/null 2>&1 && ret=true
if $ret; then
	echo "$(tput setaf 2)User $APP_USER Exist$(tput sgr 0)"
else
	echo "$(tput setaf 1)User $APP_USER does not exist$(tput sgr0)"
exit 0
fi



###############################
# ENV & COLOR VARIABLES
###############################
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
GIT_REPO=$1
APP_USER=$2
echo "GIT REPO: $GIT_REPO"
echo "APP_USER: $APP_USER"

###############################
# Install Softwares
###############################
echo "$(tput setaf 2)INSTALLING SOFTWARES$(tput sgr0)"
#sudo apt-get install -y curl git python python-dev python-distribute python-pip python-virtualenv supervisor nginx
#pip install uswgi 
#pip install flask
echo "$(tput setaf 2)All Software Packages Installed$(tput sgr0)"

##############################
# Creating Directories
##############################
echo "$(tput setaf 2)CREATING DIRECTORIES$(tput sgr0)"
cd /home/$APP_USER

if [ ! -d "apps"]; then
mkdir apps
fi

cd /home/$APP_USER/apps

# Create Production App directory if it dosen't exist
if [ ! -d "production_app" ]; then
mkdir production_app
fi

# Create Development App directory if it dosen't exist
if [ ! -d "development_app" ]; then
mkdir development_app
fi

# RUN git clone only when its not been cloned other wise run git pull
if [ ! -d "CI-Boilerplate" ]; then
cd Boilerplate
git clone https://github.com/ankitjamuar/CI_Boilerplate.git
fi

# Run git pull if its already cloned
if [ -d "CI-Boilerplate" ]; then
cd CI-Boilerplate
git pull https://github.com/ankitjamuar/CI-Boilerplate.git
fi

cp uwsgi.ini /etc/uwsgi/apps-enabled/
cp app_nginx.conf /etc/nginx/sites-enabled

#####################################
# Restarting UWSGI & NGINX
#####################################
echo "$(tput setaf 2)Restarting UWSGI$(tput sgr0)"
sudo service uwsgi restart
sudo service nginx restart
exit 0
