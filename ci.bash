clear
echo "Tagbin Services Pvt Ltd"
echo "Run the command as ci.bash http://bitbucket.org/repo.git root"

#######################################
# Check if GIT REPO is passed as params
#######################################
if [ -z "$1" ] 
then
echo "No GIT REPO Provided"
exit 0
fi 

###############################
# Check is username is provided
###############################
if [-z "$2" ]
then
echo "No User provided"
exit 0
fi

###############################
# ENV VARIABLES
###############################
GIT_REPO=$1
APP_USER=$2
echo "GIT REPO: $GIT_REPO"
echo "APP_USER: $APP_USER"

###############################
# Install Softwares
###############################
echo "INSTALLING SOFTWARES"
sudo apt-get install -y curl git python python-dev python-distribute python-pip python-virtualenv supervisor nginx

exit 0
