const express = require('express');
const taxirideModel = require('../models/taxirideModel');
const userModel = require('../models/userModel');

const { default: mongoose } = require('mongoose');
const taxiModel = require('../models/taxiModel');
const share_rideModel = require('../models/share_rideModel');
const taxirideRouter = express.Router();
const objectid = mongoose.Types.ObjectId

taxirideRouter.post('/taxiride', async function (req, res) {
  try {
    const data = {
      user_id: req.body.user_id,
      address: req.body.address,
      destination: req.body.destination,
      posting_date: req.body.posting_date,
      posting_tim: req.body.posting_tim,
      Date: req.body.Date,
      Status: '0',
      pickup: '60',
      ace: '0',
      total: '0',
      taxi_id:null,
      time: req.body.time,
    };

    const savedData = await taxirideModel(data).save();
    console.log(savedData);

    if (savedData) {
      return res.status(200).json({
        success: true,
        error: false,
        details: savedData,
        message: "Ride shared"
      });
    }
  } catch (error) {
    return res.status(400).json({
      success: false,
      error: true,
      message: "Something went wrong"
    });
  }
});


taxirideRouter.get('/viewtaxi', async function (req, res) {
  try {

      const allUser = await taxirideModel.aggregate([
          {
            '$lookup': {
              'from': 'user_tbs', 
              'localField': 'user_id', 
              'foreignField': '_id', 
              'as': 'login'
          }
          },
          {
              '$unwind':"$login"
          },
          {
            '$match':{
                'Status':'0'
            }
        },
         
          {
              '$group':{
                '_id': '$_id',
                'user_id': { '$first': '$login._id' },
                'address': { '$first': '$address' },
                'destination': { '$first': '$destination' },
                'posting_date': { '$first': '$posting_date' },
                'posting_tim': { '$first': '$posting_tim' },
                'Date': { '$first': '$Date' },
                'time': { '$first': '$time' },
                'Status': { '$first': '$Status' },
                'taxi_id': { '$first': '$taxi_id' },
                'first_name': { '$first': '$login.first_name' },
                'last_name': { '$first': '$login.last_name' },
                'idcardimag': { '$first': '$login.idcardimag' },
                'pickup': { '$first': '$pickup' },
                'profilepic': { '$first': '$login.profilepic' },


                  
              }
          }
        ])
      if(!allUser){
         return res.status(400).json({
              success:false,
              error:true,
              message:"No data exist"
          })
      }
      return res.status(200).json({
          success:true,
          error:false,
          data:allUser
      }) 
  } catch (error) {
      return res.status(400).json({
          success:false,
          error: true,
          message:"Something went wrong"
      })
  }
})

taxirideRouter.get('/viewuse/:id', async function (req, res) { 
  try {
      const userId = req.params.id; 
console.log(userId);
      const allUser = await userModel.aggregate([
          
          {
              '$lookup': {
                  'from': 'login_tbs',
                  'localField': 'login_id',
                  'foreignField': '_id',
                  'as': 'login'
              }
          },
          {
              '$unwind': "$login"
          },
          {
            '$match': { 'login._id': new objectid (userId) } 
        },
          {
              '$group': {
                  '_id': '$_id',
                  'login_id': { '$first': '$login._id' },
                  'idcard': { '$first': '$idcard' },
                  'first_name': { '$first': '$first_name' },
                  'Phone_no': { '$first': '$Phone_no' },
                  'last_name': { '$first': '$last_name' },
                  'status': { '$first': '$login.status' },
                  'address': { '$first': '$address' },
                  'email': { '$first': '$email' },
                  'gender': { '$first': '$gender' },
                  'username': { '$first': '$login.username' },
                  'idcardimag':{'$first':'$idcardimag'},
                  'profilepic':{'$first':'$profilepic'},
              }
          }
      ]);

      if (allUser.length === 0) { 
          return res.status(400).json({
              success: false,
              error: true,
              message: "No data exist"
          });
      }

      return res.status(200).json({
          success: true,
          error: false,
          data: allUser
      });

  } catch (error) {
      return res.status(400).json({
          success: false,
          error: true,
          message: "Something went wrong"
      });
  }
});
taxirideRouter.get('/viewtaxi/:id', async function (req, res) { 
  try {
      const userId = req.params.id; 
console.log(userId);
      const allUser = await taxiModel.aggregate([
          
          {
              '$lookup': {
                  'from': 'login_tbs',
                  'localField': 'login_id',
                  'foreignField': '_id',
                  'as': 'login'
              }
          },
          {
              '$unwind': "$login"
          },
          {
            '$match': { 'login._id': new objectid (userId) } 
        },
          {
              '$group': {
                  '_id': '$_id',
                  'login_id': { '$first': '$login._id' },
                  'idcard': { '$first': '$idcard' },
                  'car_num': { '$first': '$car_num' },
                  'first_name': { '$first': '$first_name' },
                  'Phone_no': { '$first': '$Phone_no' },
                  'last_name': { '$first': '$last_name' },
                  'status': { '$first': '$login.status' },
                  'address': { '$first': '$address' },
                  'email': { '$first': '$email' },
                  'gender': { '$first': '$gender' },
                  'username': { '$first': '$login.username' },
                  'idcardimag':{'$first':'$idcardimag'},
                  'profilepic':{'$first':'$profilepic'},
              }
          }
      ]);

      if (allUser.length === 0) { 
          return res.status(400).json({
              success: false,
              error: true,
              message: "No data exist"
          });
      }

      return res.status(200).json({
          success: true,
          error: false,
          data: allUser
      });

  } catch (error) {
      return res.status(400).json({
          success: false,
          error: true,
          message: "Something went wrong"
      });
  }
});

taxirideRouter.get('/accept/:id/:taxi/:fareAmount', async (req, res) => {
  try {
    const id = req.params.id;
    const taxiid =new objectid (req.params.taxi);
    const total1 =req.params.fareAmount;
    
const accept = await taxirideModel.updateOne({ _id: id }, { $set: { Status: 1,taxi_id:taxiid,total:total1 } });
 console.log(accept);
    if (accept && accept.modifiedCount === 1) {
      return res.status(200).json({
        success: true,
        message: 'job accepted',
      });
    } else if (accept && accept.modifiedCount === 0) {
      return res.status(400).json({
        success: false,
        message: 'User not found or already job accepted',
      });
    } else {
      throw new Error('Error updating user');
    }
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: 'Something went wrong',
      details: error.message,
    });
  }
});


taxirideRouter.get('/viewtaxi2/:id', async function (req, res) {
  try {
    const userId = req.params.id; 
    console.log(userId);
      const allUser = await taxirideModel.aggregate([
          {
            '$lookup': {
              'from': 'taxi_tbs', 
              'localField': 'taxi_id', 
              'foreignField': '_id', 
              'as': 'result'
            }
          },
          {
              '$unwind':"$result"
          },
          {
            
              '$match': { 'user_id': new objectid (userId) } 
          },
         
          {
              '$group':{
                '_id': '$_id',
                'user_id': { '$first': '$result._id' },
                'address': { '$first': '$address' },
                'destination': { '$first': '$destination' },
                'posting_date': { '$first': '$posting_date' },
                'posting_tim': { '$first': '$posting_tim' },
                'Date': { '$first': '$Date' },
                'time': { '$first': '$time' },
                'Status': { '$first': '$Status' },
                'taxi_id': { '$first': '$taxi_id' },
                'first_name': { '$first': '$result.first_name' },
                'last_name': { '$first': '$result.last_name' },
                'idcardimag': { '$first': '$result.idcardimag' },
                'car_num': { '$first': '$result.car_num' },
                'ace': { '$first': '$result.ace' },
                
                'pickup': { '$first': '$result.pickup' },
                'profilepic': { '$first': '$result.profilepic' },

                  
              }
          }
        ])
      if(!allUser){
         return res.status(400).json({
              success:false,
              error:true,
              message:"No data exist"
          })
      }
      return res.status(200).json({
          success:true,
          error:false,
          data:allUser
      }) 
  } catch (error) {
      return res.status(400).json({
          success:false,
          error: true,
          message:"Something went wrong"
      })
  }
})




module.exports = taxirideRouter;
