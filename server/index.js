// Import required libraries and modules
const express = require('express'); // Express.js for building web applications
const http = require('http'); // Node.js HTTP module for creating an HTTP server
const mongoose = require('mongoose'); // Mongoose for working with MongoDB
const app = express(); // Create an instance of the Express application
const port = process.env.PORT || 3001; // Define the port to run the server on
const SignUp = require('./models/signup'); // Import the 'signup' model

// Create an HTTP server using Express
var server = http.createServer(app);

// Use middleware to handle JSON and URL-encoded data
app.use(express.json()); // Parse JSON requests
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded requests

// Enable Cross-Origin Resource Sharing (CORS)
const cors = require("cors");
app.use(cors());

// MongoDB connection string
const DB =  'mongodb+srv://abhinav:giri@cluster1.f5hitoc.mongodb.net/flutter';

// An empty array for storing signup data (not recommended as it's not being used)
const signupData = [];

// Connect to the MongoDB database
mongoose.connect(DB).then(() => {
    console.log("Connection successful!");

    // Define a route to handle POST requests for signup
    app.post('/api/signup', async (req, res) => {
        let data = SignUp(req.body); // Create a new SignUp instance with request data

        try {
            let signupData = await data.save(); // Save the data to the database
            res.status(200).json(signupData); // Respond with the saved data
        } catch (error) {
            res.status(400).json({
                'status': error.message // Respond with an error if data cannot be saved
            });
        }
    });

    // Define a route to handle GET requests for signup data by email
    app.get('/api/get_signup:email', async (req, res) => {
        try {
            const signup_data = await SignUp.findOne({ 'email': req.params.email }); // Find data by email

            if (signup_data != null) {
                res.status(200).json({ 'data': signup_data }); // Respond with the found data
            } else {
                res.status(404).json({ 'error': 'Signup data not found', 'rr': req.params.email }); // Respond with an error if data is not found
            }
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' }); // Respond with a server error if an exception occurs
        }
    });

    // Define a route to handle PATCH requests for updating data by ID
    app.patch('/api/count:id', async (req, res) => {
        console.log("Result", req.body);
        let id = (req.params.id).toString();
        let options = { new: true };

        try {
            const data = await SignUp.findByIdAndUpdate(id, req.body, options); // Find and update data by ID

            let signupData = await data.save(); // Save the updated data
            res.status(200).json(signupData); // Respond with the updated data
        } catch (error) {
            res.status(400).json({
                'status': error.message // Respond with an error if the update fails
            });
        }
    });

    // Define a route to handle PATCH requests for adding items (similar to the previous PATCH route)
    app.patch('/api/items', async (req, res) => {
        let data = SignUp(req.body);

        try {
            let signupData = data.save(); // Save the data (similar to the POST route)
            res.status(200).json(signupData);
        } catch (error) {
            res.status(400).json({
                'status': error.message
            });
        }
    });

    // Start the server and listen on the specified port and IP address
    server.listen(port, '0.0.0.0', () => {
        console.log(`Server is running on port ${port}`);
    });
});
