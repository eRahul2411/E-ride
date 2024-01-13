const mongoose = require("mongoose");

const schema = mongoose.Schema

const carSchema = new schema({
    user_id: { type: mongoose.Types.ObjectId, ref:'user_tb' },
    car_details: { type: String },
    District: { type: String },
    car_image: { type: String },
    status: { type: String },
    seat: { type: String },
    auto: { type: String },
    petrol: { type: String },
    prize: { type: String },
    name: { type: String },
    location: { type: String },
    discription: { type: String },
    Adress: { type: String },
})

const carModel = mongoose.model('car_tb',carSchema)
module.exports = carModel