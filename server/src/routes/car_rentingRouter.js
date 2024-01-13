const express = require('express');
const car_rentingModel = require('../models/car_rentingModel');
const car_rentingRouter = express.Router();

car_rentingRouter.post('/car_renting', async function (req, res) {
  try {
    const data = {
      user_id: req.body.user_id,        
      car_renting_time: req.body.car_renting_time,
      car_renting_date: req.body.car_renting_date,
    };

    const savedData = (await car_rentingModel(data)).save();
    console.log(savedData);
    
    if (savedData) {
      return res.status(200).json({
        success: true,
        error: false,
        details: savedData,
        message: "Registration completed"
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

module.exports = car_rentingRouter;
