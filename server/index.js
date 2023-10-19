const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3001;
const SignUp = require('./models/signup');

var server = http.createServer(app);
app.use(express.json());
app.use(express.urlencoded({extended: true}));


// const DB = 'mongodb+srv://abhinav:giri@cluster1.f5hitoc.mongodb.net/?retryWrites=true&w=majority'

const productData = [];
app.post('/api/signup', (req, res)=>{
    console.log("Result", req.body);
    const pdata = {
        "email":  req.body.email,
        "passsword": req.body.password,
        
    };
    productData.push(pdata);
    console.log('SignUp Details: ',pdata);
    res.status(200).send({
        "status_code" : 200,
        "message": "Login Successful",
        "loginDetails" : pdata
    });
}

)

// mongoose.connect(DB).then(()=>{
//     console.log("Connection successful!");
// }).catch((e)=> {console.log(e);
// })

server.listen(port, '0.0.0.0', ()=>{
    console.log(`Server is runing on port ${port}`)
});