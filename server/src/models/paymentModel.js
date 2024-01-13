const mongoose = require("mongoose");

const schema = mongoose.Schema

const paymentSchema = new schema({
    user_id: { type: mongoose.Types.ObjectId, ref:'user_tb' },
    driver_id: { type: mongoose.Types.ObjectId, ref:' driver_tb' },
    amount: { type: String },
    date: { type: String },
    time: { type: String },
    status: { type: String },
 
  
    
})

const paymentModel = mongoose.model('payment_tb',paymentSchema)
module.exports = paymentModel