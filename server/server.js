const express = require('express');
const mongoose = require("mongoose");
const registerRouter = require('./src/routes/registerRouter');
const loginRouter = require('./src/routes/loginRouter');
const car_rentingRouter = require('./src/routes/car_rentingRouter');
const carRouter = require('./src/routes/carRouter');
const driver_bookingRouter = require('./src/routes/driver_bookingRouter');
const paymentRouter = require('./src/routes/paymentRouter');
const reviewRouter = require('./src/routes/reviewRouter');
const share_rideRouter = require('./src/routes/share_rideRouter');
const taxihRouter = require('./src/routes/taxihRouter');
const taxirideRouter = require('./src/routes/taxirideRouter');



const app = express();


app.use(express.urlencoded({ extended: true }));

app.get('/', function (req, res) {
  res.send("hellossdfsdf");
});


app.use(express.static('./public'));
app.use(express.static('./taxiprofilepic'));
app.use(express.static('./driverprofilepic'));
app.use(express.static('./userid'));
app.use(express.static('./userprofilepic'));
app.use(express.static('./taxiid'));
app.use(express.static('./driverid'));
app.use('/register', registerRouter);
app.use('/login', loginRouter);
app.use('/car_renting', car_rentingRouter);
app.use('/car', carRouter);
app.use('/driver_booking', driver_bookingRouter);
app.use('/payment', paymentRouter);
app.use('/review', reviewRouter);
app.use('/shareride', share_rideRouter);
app.use('/taxiride', taxirideRouter);
app.use('/taxih', taxihRouter);

mongoose.connect('mongodb+srv://dxad004:dxad004@cluster0.mnvtpxk.mongodb.net/E-rideDB?retryWrites=true&w=majority').then(()=>{
  app.listen(3000, function () {
    console.log("Server started at http://localhost:3000");
  });
}).catch((err)=>{
  console.log(err);
})


