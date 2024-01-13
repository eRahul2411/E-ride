const mongoose = require("mongoose");

const schema = mongoose.Schema

const userSchema = new schema({
    login_id: { type: mongoose.Types.ObjectId, ref:'login_tb' },
    first_name: { type: String },
    last_name: { type: String },
    Phone_no: { type: String },
    address: { type: String },
    email: { type: String },
    gender: { type: String },
    dob: { type: String },
    img1: { type: String },
    idcard: { type: String },
    idcardimag: { type: String },
    profilepic: { type: String },


})

const userModel = mongoose.model('user_tb',userSchema)
module.exports = userModel