const mongoose = require("mongoose");

const schema = mongoose.Schema

const driver_bookingSchema = new schema({
   
    user_id: { type: mongoose.Types.ObjectId, ref:'user_tb' },
    driver_id: { type: mongoose.Types.ObjectId, ref:'driver_tb' },
    driver_booking_time: { type: String },
    driver_booking_date: { type: String },
    adres: { type: String },
    ndays: { type: String },
    status: { type: String },
    job: { type: String },
    price: { type: String },
    status: { type: String },
    
  
    
})

const driver_bookingModel = mongoose.model('driver_booking_tb',driver_bookingSchema)
module.exports = driver_bookingModel