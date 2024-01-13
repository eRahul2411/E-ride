const mongoose = require("mongoose");

const schema = mongoose.Schema

const reviewSchema = new schema({
   
    user_id: { type: mongoose.Types.ObjectId, ref:'user_tb' },
    driver_id: { type: mongoose.Types.ObjectId, ref:'driver_tb' },
    review_time: { type: String },
    review_date: { type: String },
    review_detail: { type: String },
  
    
})

const reviewModel = mongoose.model('review_tb',reviewSchema)
module.exports = reviewModel