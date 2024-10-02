# Exercise 10

## MongoDB in a Flask Application
In this tutorial, I will build a small web application that demonstrates how to use the PyMongo library to interact with a MongoDB database in Python.

### 1. Setting up PyMongo and Flask
Install Flask and the PyMongo library in my virtual environment.


#### a. Install the python3-venv package

```
sudo apt install -y python3-venv
```

#### b.Create and activate the virtual environment
```
mkdir ~/myproject
cd ~/myproject
python3 -m venv myprojectenv
source myprojectenv/bin/activate
```

<img width="796" alt="Screenshot 2024-10-02 at 11 12 54 PM" src="https://github.com/user-attachments/assets/aa4e77db-ce86-4f2f-8ec2-306dce7f8b53">

#### c.Install Flask and PyMongo

```
pip install Flask flask_pymongo
```

### 2. Install MongoDB and Configure the Application

**Install MongoDB**

```
sudo apt update
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable --now mongod
```

#### App Code
Create a file named app.py and add the following code:

```
from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson import ObjectId, json_util

app = Flask(__name__)
app.config['MONGO_URI'] = "mongodb://localhost:27017/crud_db"
connect_db = PyMongo(app)

def convert_id(data):
    if isinstance(data, ObjectId):
        return str(data)
    if isinstance(data, dict):
        for key in data:
            if isinstance(data[key], ObjectId):
                data[key] = str(data[key])
            elif isinstance(data[key], dict):
                data[key] = convert_id(data[key])
    return data

@app.route('/items', methods=['POST'])
def create_item():
    data = request.json
    result = connect_db.db.product.insert_one(data)
    return jsonify({"status": "created successfully", "id": str(result.inserted_id)})

@app.route('/items', methods=['GET'])
def get_items():
    data = connect_db.db.product.find()
    return jsonify([convert_id(item) for item in data])

@app.route('/items/<id>', methods=['GET'])
def get_item(id):
    item = connect_db.db.product.find_one({"_id": ObjectId(id)})
    if item:
        return jsonify(convert_id(item))
    return jsonify({"error": "Item not found"}), 404

@app.route('/items/<id>', methods=['PUT'])
def update_item(id):
    data = request.json
    result = connect_db.db.product.update_one({"_id": ObjectId(id)}, {"$set": data})
    if result.matched_count:
        return jsonify({"status": "updated successfully"})
    return jsonify({"error": "Item not found"}), 404

@app.route('/items/<id>', methods=['DELETE'])
def delete_item(id):
    result = connect_db.db.product.delete_one({"_id": ObjectId(id)})
    if result.deleted_count:
        return jsonify({"status": "deleted successfully"})
    return jsonify({"error": "Item not found"}), 404

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
```


### 3. Interact with the API

#### Create an item

```
curl -X POST http://localhost:5000/items \
-H "Content-Type: application/json" \
-d '{"name": "John Doe", "age": 30, "place": "New York"}'
```

#### Get all items:

```
curl -X GET http://localhost:5000/items
```

#### Get a specific item:

```
curl -X GET http://localhost:5000/items/<id>
```

#### Update a specific item:

```
curl -X PUT http://localhost:5000/items/<id> \
-H "Content type: application/json" \
-d '{"name": "Jane Doe", "age": 31, "place": "Los Angeles"}'
```


#### Delete a specific item:

```
curl -X DELETE http://localhost:5000/items/<id>
```
