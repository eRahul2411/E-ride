const mongoose = require("mongoose");

const schema = mongoose.Schema

const taxirideSchema = new schema({
    user_id: { type: mongoose.Types.ObjectId, ref:'user_tb' },
    taxi_id: { type: mongoose.Types.ObjectId, ref:'taxi_tb' },
    address: { type: String },
    destination: { type: String },
    Date: { type: String },
    Status: { type: String },
    pickup: { type: String },
    ace: { type: String },
    posting_date: { type: String },
    posting_tim: { type: String },
    time: { type: String },
    total: { type: String },
  
    
})

const taxirideModel = mongoose.model('taxiride_tb',taxirideSchema)
module.exports = taxirideModel