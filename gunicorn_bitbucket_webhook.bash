#####################################################
#
# This is for DJANGO but can be used for any WSGI app
#
#####################################################

NAME="bitbucket_webhook"                           # Name of the application
DJANGODIR=/home/root/apps/bitbucket_webhook             # Django project directory
SOCKFILE=/home/root/apps/bitbucket_webhook.sock   # we will communicte using this unix socket
USER=root                                        # the user to run as
GROUP=root                                    # the group to run as
NUM_WORKERS=3                                     # how many worker processes should Gunicorn spawn
#DJANGO_SETTINGS_MODULE=hello.settings             # which settings file should Django use
DJANGO_WSGI_MODULE=hook                          # WSGI module name

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
#source ../bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec gunicorn ${DJANGO_WSGI_MODULE}:app \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
