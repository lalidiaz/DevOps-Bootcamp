# Challenge: Deploy MongoDB and Mongo Express Containers

## Objective

In this challenge, you will create a Docker environment that includes two containers: one for MongoDB and another for Mongo Express. MongoDB will be secured with a username and password, while Mongo Express will allow you to manage the database through a web interface.

## Instructions

1. Create the MongoDB container:

- Use Docker to create a MongoDB container.
- Configure the container with the necessary environment variables to set up a username and password for access.

2. Set up Mongo Express:

- Deploy a second container with Mongo Express.
- Ensure that Mongo Express is connected to the MongoDB container you created earlier.

3. Connect to Mongo Express:

- Access the Mongo Express web interface through your browser.
- Create a database named Library with a collection called Books.

4. Import data into MongoDB:

On your machine, place the books.json file with the following content:

```
[
    { "title": "Docker in Action, Second Edition", "author": "Jeff Nickoloff and Stephen Kuenzli" },
    { "title": "Kubernetes in Action, Second Edition", "author": "Marko Lukša" }
]
```

- Use the Mongo Express interface to import the data from books.json into the Books collection in the Library database.

## Notes

In this challenge, we use Mongo Express instead of Mongo Compass to simplify the setup and allow the solution to be completely container-based.

## My Solution ✅

1. Created docker-compose.yml

2. Import books.json into Books collection in Library DB.
<img width="1911" alt="Screenshot 2024-10-25 at 7 36 19 AM" src="https://github.com/user-attachments/assets/2194b8be-61a1-4b1e-a7ea-de130f013d3c">
