# CI-Boilerplate
This project is a boiler plate for any project start, it consist of following things and is Dockerized.

- Git Listener: Its a  Django and Flask App hooked to Github/Bitbucket/Gitlab for auto pulling code based on the branch it is pushed to.
  We generally have two branch one for production and one for development,  user will push to either of them and this 
  flask app will pull the code and place it in appropriate folder.
  
- UWSGI: Webserver to serve the Git Listener and other python projects.

- Supervisord: Process Manager to keep track of running process.

- Nginx: Proxy server

- Directory Structure:
  ```
/home/user/apps/
    - /production_app      -> Linked to Master Branch of Git Repo
    - /development_ap p    -> Linked to Development Branch of Git Repo
    - /CI_Boilerplate      -> Flask App that auto pull codes from Github/Bitbucket/Gitlab
```
