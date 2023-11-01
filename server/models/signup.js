// Import the Mongoose library to work with MongoDB
const mongoose = require("mongoose");

// Define a Mongoose schema for the "grocery" collection
let dataSchema = new mongoose.Schema({
    // Define the schema fields with their properties

    'email': {
        required: true, 
        type: String,    
    },
    'password': {
        required: true, 
        type: String,    
    },
    'count': {
        type: String,     
        default: '0',    
    },
    shopItems: [] // An array field to store shop items
});

// Export the Mongoose model with the schema, which is named "grocery"
module.exports = mongoose.model("grocery", dataSchema);
