const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3001;
const SignUp = require('./models/signup');

var server = http.createServer(app);
app.use(express.json());
app.use(express.urlencoded({extended: true}));

const cors = require("cors");
app.use(cors());
const DB = 'mongodb+srv://abhinav:giri@cluster1.f5hitoc.mongodb.net/flutter'
// mongodb+srv://abhinav:<password>@cluster1.f5hitoc.mongodb.net/?retryWrites=true&w=majority
const signupData = [];


// app.get('/api/get_signup',(req,res)=>{
//     const pdata = {
//         "email":  req.body.email,
//         "passsword": req.body.password,
        
//     };
//     res.status(200).send({
//         "status_code" : 200,
//         "message": "Successfuly Fetched Data"}
// )
// });

// 'useUnifiedTopology' : true
// mongoose.set('strictQuery',true);
mongoose.connect(DB).then(()=>{
    console.log("Connection successful!");

    app.post('/api/signup', async(req, res)=>{
        console.log("Result", req.body);
       let data =  SignUp(req.body);
      try{
        let signupData = await data.save();
        res.status(200).json(signupData);

      }catch (error){
        res.status(400).json({
            'status': error.message
        })

      }
        
    },);
    app.get('/api/get_signup:email', async (req, res) => {
      try {
        const signup_data = await SignUp.findOne({ 'email': req.params.email });
        // const signup_data = await SignUp.find();
        if (signup_data != null) {
          console.log('API is running...');
          res.status(200).json({ 'data': signup_data });
        } else {
          console.log('API is not running...');
          res.status(404).json({ 'error': 'Signup data not found' , 'rr': req.params.email});
        }
      } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal server error' });
      }
    });
    
    app.patch('/api/count:id', async(req, res)=>{
      console.log("Result", (req.body));
     let id = (req.params.id).toString();
     let options = {new: true};

    try{
      const data = await SignUp.findByIdAndUpdate(id,req.body,options);
      
      let signupData = await data.save();
      console.log("UpdatedCountPrintttttt",signupData);
      res.status(200).json(signupData);

    }catch (error){
      res.status(400).json({
          'status': error.message
      })

    }
      
  },);

//   app.patch('/api/count:id', async(req, res)=>{
//     console.log("Result", req.body);
//    let id = (req.params.id).toString();
//    let options = {new: true};

//   try{
//     const data = await SignUp.findByIdAndUpdate(id,req.body,options);
    
//     let signupData = await data.save();
//     console.log("UpdatedItemssssssss",signupData);
//     res.status(200).json(signupData);

//   }catch (error){
//     res.status(400).json({
//         'status': error.message
//     })

//   }
    
// },);



  app.patch('/api/items', async(req, res)=>{
    console.log("Result", req.body);
   let data =  SignUp(req.body);
  try{
    let signupData = data.save();
    res.status(200).json(signupData);

  }catch (error){
    res.status(400).json({
        'status': error.message
    })

  }
    
},);
  
  });
server.listen(port, '0.0.0.0', ()=>{
    console.log(`Server is runing on port ${port}`)
});


