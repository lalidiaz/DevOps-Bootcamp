# Exercise 06

## Deploy a Python application with Flask
I will learn to deploy a Flask application on an Ubuntu server. 
Flask is a Python microframework that makes it easy to create web applications.

###  Install the Components from the Ubuntu Repositories
First, update the local package index and install the necessary packages, including pip, the Python package manager, and other development packages:
```
sudo apt update
sudo apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
```

### Create a Python Virtual Environment
Set up a virtual environment to isolate your Flask application from the system's Python packages:

#### Install the python3-venv package
```
sudo apt install -y python3-venv
```

#### Create and activate the virtual environment
```
mkdir ~/myproject
cd ~/myproject
python3 -m venv myprojectenv
source myprojectenv/bin/activate
```

You will see the prefix (myprojectenv) in your terminal, indicating that you are working within the virtual environment.
<img width="767" alt="Screenshot 2024-10-02 at 7 56 03 AM" src="https://github.com/user-attachments/assets/a228d100-9240-4e48-9ea3-4a1fa3228975">

### Configure the Flask Application

#### Install Flask
Make sure that wheel is installed and then install Flask:
```
pip install wheel
```

<img width="807" alt="Screenshot 2024-10-02 at 7 57 38 AM" src="https://github.com/user-attachments/assets/d9c2f756-5ea4-4377-8e46-8b2a526a6603">

```
pip install flask
```
<img width="819" alt="Screenshot 2024-10-02 at 7 58 05 AM" src="https://github.com/user-attachments/assets/c2855bd3-3e57-4258-9ae6-eda6a3a6d271">

#### Create a sample application
Create a file named myproject.py with the following content:

```
cat > myproject.py
```
```
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello Bootcampers RoxsOps!</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
```
Save the file and close the editor.
<img width="763" alt="Screenshot 2024-10-02 at 8 01 32 AM" src="https://github.com/user-attachments/assets/0cabe424-0f93-439c-ae1a-d1248f04d239">


#### Test the application
Run the Flask application
```
python myproject.py
```

### Final Result 🎉✅ 
Open your browser and visit http://localhost:5000 to see the application in action.
You should see the message 'Hello Bootcampers RoxsOps!'.
<img width="1843" alt="Screenshot 2024-10-02 at 8 04 30 AM" src="https://github.com/user-attachments/assets/abb8907c-cb45-4c80-adfb-40e271822340">
