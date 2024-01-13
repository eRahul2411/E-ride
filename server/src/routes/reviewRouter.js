const express = require('express');
const reviewModel = require('../models/reviewModel');

const reviewRouter = express.Router();

reviewRouter.post('/review', async function (req, res) {
  try {
    const data = {
      user_id: req.body.user_id,        
      driver_id: req.body.driver_id,
      review_time: req.body.review_time,
      review_date: req.body.review_date,
      review_detail: req.body.review_detail,

};

    const savedData = await reviewModel(data).save();
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


module.exports = reviewRouter;
