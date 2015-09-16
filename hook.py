from flask import Flask
import subprocess
import os

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
	#print subprocess.call(['pwd'])
	os.chdir( '/home/ubuntu/apps/reload_pos/' )
	output = subprocess.check_output(["git", "pull"])
	return output
    

@app.route('/')
def index():
    return '{message: CI Server!, success:True}'


if __name__ == '__main__':
    app.run(debug=True) 
