const mongoose = require("mongoose");

// const shopItemSchema = new mongoose.Schema({
//     'name': {
//       type: String,
//       default: '',
//     },
//     // 'price': {
//     //   type: String,
//     //   default: '',
//     // },
//     // 'image': {
//     //   type: String,
//     //   default: '',
//     // },
//     // 'color': {
//     //   type: String,
//     //   default: '',
//     // },
//     'quantity': {
//       type: Number,
//       default: 0,
//     },
//   });
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
shopItems: [],
});

module.exports = mongoose.model("grocery", dataSchema);