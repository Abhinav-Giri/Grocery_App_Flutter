const mongoose = require("mongoose");

let dataSchema = new mongoose.Schema({

    'email':{
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
});

module.exports = mongoose.model("grocery", dataSchema);