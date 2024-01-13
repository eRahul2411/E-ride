const mongoose = require("mongoose");

const schema = mongoose.Schema

const driverSchema = new schema({
   
    login_id: { type: mongoose.Types.ObjectId, ref:'login_tb' },
    first_name: { type: String },
    last_name: { type: String },
    Phone_no: { type: String },
    address: { type: String },
    email: { type: String },
    gender: { type: String },
    dob: { type: String },
    idcard: { type: String },
    idcardimag: { type: String },
    price: { type: String },
    profilepic: { type: String },
    
  
    
})

const driverModel = mongoose.model('driver_tb',driverSchema)
module.exports = driverModel