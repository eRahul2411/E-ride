const mongoose = require("mongoose");

const schema = mongoose.Schema

const takeriseSchema = new schema({
    user_id: { type: mongoose.Types.ObjectId, ref:'login_tb' },
    shareid: { type: mongoose.Types.ObjectId, ref:'share_ride_tb' },
    
    status: { type: String }, 
})

const takeriseModel = mongoose.model('takeride_tb',takeriseSchema)
module.exports = takeriseModel
