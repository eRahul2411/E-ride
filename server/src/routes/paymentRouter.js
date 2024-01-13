const express = require('express');
const paymentModel = require('../models/paymentModel');
paymentModel

const paymentRouter = express.Router();

paymentRouter.post('/payment', async function (req, res) {
  try {
    const data = {
      user_id: req.body.user_id,        
      driver_id: req.body.driver_id,
      amount: req.body.amount,
      date: req.body.date,
      time: req.body.time,
      status: req.body.status,
    };

    const savedData = await paymentModel(data).save();
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

module.exports = paymentRouter;
