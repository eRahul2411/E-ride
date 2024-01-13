const express = require('express');
const { default: mongoose } = require('mongoose');
const share_rideModel = require('../models/share_rideModel');
const takeriseModel = require('../models/takeriseModel');
const taxiModel = require('../models/taxiModel');
const loginModel = require('../Models/loginModel');
const driverModel = require('../models/driverModel');
const objectid = mongoose.Types.ObjectId

const taxihRouter = express.Router();


taxihRouter.post('/updatetaxi/:id', async function (req, res) { 
  try {
      const productId = req.params.id; 
      const details = {
        email: req.body.email,
        Phone_no : req.body.Phone_no,
          
      }
      const product = await taxiModel.updateOne({_id:productId},{$set:details})

      if (product.modifiedCount!=1) { 
          return res.status(400).json({
              success: false,
              error: true,
              message: "Data not updated"
          });
      }

      return res.status(200).json({
          success: true,
          error: false,
          data: product,
          message:"Data updated"
      });

  } catch (error) {
      return res.status(400).json({
          success: false,
          error: true,
          message: "Something went wrong"
      });
  }
});
taxihRouter.post('/updatedriver/:id', async function (req, res) { 
    try {
        const productId = req.params.id; 
        const details = {
          email: req.body.email,
          Phone_no : req.body.Phone_no,
            
        }
        const product = await driverModel.updateOne({_id:productId},{$set:details})
  
        if (product.modifiedCount!=1) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "Data not updated"
            });
        }
  
        return res.status(200).json({
            success: true,
            error: false,
            data: product,
            message:"Data updated"
        });
  
    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
  });    

taxihRouter.post('/updatetaxipass/:id', async function (req, res) { 
  try {
      const productId = req.params.id; 
      const details = {
        password: req.body.password,
       
          
      }
      const product = await loginModel.updateOne({_id:productId},{$set:details})

      if (product.modifiedCount!=1) { 
          return res.status(400).json({
              success: false,
              error: true,
              message: "Data not updated"
          });
      }

      return res.status(200).json({
          success: true,
          error: false,
          data: product,
          message:"Data updated"
      });

  } catch (error) {
      return res.status(400).json({
          success: false,
          error: true,
          message: "Something went wrong"
      });
  }
});  


taxihRouter.post('/updatetaxipass/:id', async function (req, res) { 
  try {
      const productId = req.params.id; 
      const details = {
        password: req.body.password,
       
          
      }
      const product = await loginModel.updateOne({_id:productId},{$set:details})

      if (product.modifiedCount!=1) { 
          return res.status(400).json({
              success: false,
              error: true,
              message: "Data not updated"
          });
      }

      return res.status(200).json({
          success: true,
          error: false,
          data: product,
          message:"Data updated"
      });

  } catch (error) {
      return res.status(400).json({
          success: false,
          error: true,
          message: "Something went wrong"
      });
  }
});  


module.exports = taxihRouter;