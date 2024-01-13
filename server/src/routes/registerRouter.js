const express = require('express')
const userModel = require('../models/userModel')

const taxiModel = require('../models/taxiModel')
const driverMOdel = require('../models/driverModel')
const loginModel = require('../Models/loginModel')
const { default: mongoose } = require('mongoose')
const multer = require('multer');
const objectid = mongoose.Types.ObjectId

const registerRouter = express.Router()
var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "./public/images/")
    },
    filename: function (req, file, cb) {
        cb(null,file.originalname)
    }
  })
  
  var upload = multer({ storage: storage })

registerRouter.get('/viewstatus-driver', async function (req, res) {
    try {

        const allUser = await driverMOdel.aggregate([
            {
                '$lookup': {
                    'from': 'login_tbs', 
                    'localField': 'login_id', 
                    'foreignField': '_id', 
                    'as': 'login'
                }
            },
            {
                '$unwind':"$login"
            },
            {
              '$match':{
                'login.status':'1'
            }

            },
            {
                '$group':{
                    '_id':'$_id',
                    'id':{'$first':'$login._id'},
                    'first_name':{'$first':'$first_name'},
                    'Phone_no':{'$first':'$Phone_no'},
                    'last_name':{'$first':'$last_name'},
                    'status':{'$first':'$login.status'},
                    'address':{'$first':'$address'},
                    'email':{'$first':'$email'},
                    'gender':{'$first':'$gender'},
                    'username':{'$first':'$login.username'},
                    
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
          ])
        if(!allUser){
           return res.status(400).json({
                success:false,
                error:true,
                message:"No data exist"
            })
        }
        return res.status(200).json({
            success:true,
            error:false,
            data:allUser
        })
        

      
      
    } catch (error) {
        return res.status(400).json({
            success:false,
            error: true,
            message:"Something went wrong"
        })
    }
})

registerRouter.get('/view-taxi', async function (req, res) {
    try {

        const allUser = await taxiModel.aggregate([
            {
                '$lookup': {
                    'from': 'login_tbs', 
                    'localField': 'login_id', 
                    'foreignField': '_id', 
                    'as': 'login'
                }
            },
            {
                '$unwind':"$login"
            },
            {
              '$match':{
                'login.status':'0'
            }
            },
            {
                '$group':{
                    '_id':'$_id',
                    'id':{'$first':'$login._id'},
                    'first_name':{'$first':'$first_name'},
                    'Phone_no':{'$first':'$Phone_no'},
                    'last_name':{'$first':'$last_name'},
                    'status':{'$first':'$login.status'},
                    'address':{'$first':'$address'},
                    'email':{'$first':'$email'},
                    'gender':{'$first':'$gender'},
                    'username':{'$first':'$login.username'},
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
          ])
        if(!allUser){
           return res.status(400).json({
                success:false,
                error:true,
                message:"No data exist"
            })
        }
        return res.status(200).json({
            success:true,
            error:false,
            data:allUser
        })
        

      
      
    } catch (error) {
        return res.status(400).json({
            success:false,
            error: true,
            message:"Something went wrong"
        })
    }
})
registerRouter.get('/viewstatus-taxi', async function (req, res) {
  try {

      const allUser = await taxiModel.aggregate([
          {
              '$lookup': {
                  'from': 'login_tbs', 
                  'localField': 'login_id', 
                  'foreignField': '_id', 
                  'as': 'login'
              }
          },
          {
              '$unwind':"$login"
          },
          {
            '$match':{
              'login.status':'1'
          }
          },
          {
              '$group':{
                  '_id':'$_id',
                  'id':{'$first':'$login._id'},
                  'first_name':{'$first':'$first_name'},
                  'Phone_no':{'$first':'$Phone_no'},
                  'last_name':{'$first':'$last_name'},
                  'status':{'$first':'$login.status'},
                  'address':{'$first':'$address'},
                  'email':{'$first':'$email'},
                  'gender':{'$first':'$gender'},
                  'username':{'$first':'$login.username'},
                  'idcardimag':{'$first':'$idcardimag'},
                  'profilepic':{'$first':'$profilepic'},
              }
          }
        ])
      if(!allUser){
         return res.status(400).json({
              success:false,
              error:true,
              message:"No data exist"
          })
      }
      return res.status(200).json({
          success:true,
          error:false,
          data:allUser
      })
      

    
    
  } catch (error) {
      return res.status(400).json({
          success:false,
          error: true,
          message:"Something went wrong"
      })
  }
})

registerRouter.get('/view-users', async function (req, res) {
    try {

        const allUser = await userModel.aggregate([
            {
              '$lookup': {
                'from': 'login_tbs', 
                'localField': 'login_id', 
                'foreignField': '_id', 
                'as': 'login'
              }
            },
            {
                '$unwind':"$login"
            },
            {
                '$match':{
                    'login.status':'0'
                }
            },
            {
                '$group':{
                    '_id':'$_id',
                    'id':{'$first':'$login._id'},
                    'first_name':{'$first':'$first_name'},
                    'Phone_no':{'$first':'$Phone_no'},
                    'last_name':{'$first':'$last_name'},
                    'status':{'$first':'$login.status'},
                    'address':{'$first':'$address'},
                    'email':{'$first':'$email'},
                    'gender':{'$first':'$gender'},
                    'username':{'$first':'$login.username'},
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
          ])
        if(!allUser){
           return res.status(400).json({
                success:false,
                error:true,
                message:"No data exist"
            })
        }
        return res.status(200).json({
            success:true,
            error:false,
            data:allUser
        })
        

      
      
    } catch (error) {
        return res.status(400).json({
            success:true,
            error:false,
            message:"Something went wrong"
        })
    }
})



registerRouter.get('/viewstatus-users', async function (req, res) {
    try {

        const allUser = await userModel.aggregate([
            {
              '$lookup': {
                'from': 'login_tbs', 
                'localField': 'login_id', 
                'foreignField': '_id', 
                'as': 'login'
              }
            },
            {
                '$unwind':"$login"
            },
            {
                '$match':{
                    'login.status':'1'
                }
            },
            {
                '$group':{
                    '_id':'$_id',
                    'id':{'$first':'$login._id'},
                    'first_name':{'$first':'$first_name'},
                    'Phone_no':{'$first':'$Phone_no'},
                    'last_name':{'$first':'$last_name'},
                    'status':{'$first':'$login.status'},
                    'address':{'$first':'$address'},
                    'email':{'$first':'$email'},
                    'gender':{'$first':'$gender'},
                    'gender':{'$first':'$gender'},
                    'username':{'$first':'$login.username'},
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
          ])
        if(!allUser){
           return res.status(400).json({
                success:false,
                error:true,
                message:"No data exist"
            })
        }
        return res.status(200).json({
            success:true,
            error:false,
            data:allUser
        })
        

      
      
    } catch (error) {
        return res.status(400).json({
            success:true,
            error:false,
            message:"Something went wrong"
        })
    }
})

registerRouter.get('/view-driver', async function (req, res) {
  try {

      const allUser = await driverMOdel.aggregate([
          {
            '$lookup': {
              'from': 'login_tbs', 
              'localField': 'login_id', 
              'foreignField': '_id', 
              'as': 'login'
            }
          },
          {
              '$unwind':"$login"
          },
          {
              '$match':{
                  'login.status':'0'
              }
          },
          {
              '$group':{
                  '_id':'$_id',
                  'id':{'$first':'$login._id'},
                  'first_name':{'$first':'$first_name'},
                  'Phone_no':{'$first':'$Phone_no'},
                  'last_name':{'$first':'$last_name'},
                  'status':{'$first':'$login.status'},
                  'address':{'$first':'$address'},
                  'email':{'$first':'$email'},
                  'gender':{'$first':'$gender'},
                  'username':{'$first':'$login.username'},
                  'idcardimag':{'$first':'$idcardimag'},
                  'profilepic':{'$first':'$profilepic'},
              }
          }
        ])
      if(!allUser){
         return res.status(400).json({
              success:false,
              error:true,
              message:"No data exist"
          })
      }
      return res.status(200).json({
          success:true,
          error:false,
          data:allUser
      })
      

    
    
  } catch (error) {
      return res.status(400).json({
          success:true,
          error:false,
          message:"Something went wrong"
      })
  }
})

registerRouter.post('/userid', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })

registerRouter.post('/userprofilepic', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })

registerRouter.post('/user-register', async function (req, res) {
    try {

        const oldUser = await loginModel.findOne({ username: req.body.username })
        if(oldUser){
           return res.status(400).json({
                success:true,
                error:false,
                message:"User already exist"
            })
        }
        const oldPhone = await userModel.findOne({ Phone_no: req.body.phoneNumber })
        if(oldPhone){
           return res.status(400).json({
                success:true,
                error:false,
                message:"Phone number already exist"
            })
        }

        const log_data = {
            username: req.body.username,
            password: req.body.password,
            role: 1,
            status: 0,
        }
        const save_login = await loginModel(log_data).save()
        if(save_login){
            const user_data = {
                login_id:save_login._id, 
                first_name: req.body.firstName,
                last_name: req.body.lastName,
                Phone_no: req.body.phoneNumber,
                password: req.body.password,
                email: req.body.email,    
                address: req.body.address,    
                gender: req.body.gender,    
                dob: req.body.dob,
                img1: req.body.img1, 
                idcard: req.body.idcard, 
                idcardimag: req.body.idcardimag, 
                profilepic: req.body.profilepic, 

            }
            const save_user = await userModel(user_data).save()
            if(save_user){
                return res.status(200).json({
                     success:true,
                     error:false,
                     details:save_user,
                     message:"Registration completed"
                 })
             }
        }
       
      
    } catch (error) {
        return res.status(400).json({
            success:true,
            error:false,
            message:"Something went wrong"
        })
    }
})
registerRouter.post('/taxiid', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })
  registerRouter.post('/taxiprofilepic', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })
registerRouter.post('/taxi-register', async function (req, res) {
    try {

        const oldUser = await loginModel.findOne({ username: req.body.username })
        if(oldUser){
           return res.status(400).json({
                success:true,
                error:false,
                message:"User already exist"
            })
        }
        const oldPhone = await taxiModel.findOne({ Phone_no: req.body.phoneNumber })
        if(oldPhone){
           return res.status(400).json({
                success:true,
                error:false,
                message:"Phone number already exist"
            })
        }

        const log_data = {
            username: req.body.username,
            password: req.body.password,
            role: 2,
            status: 0,
        }
        const save_login = await loginModel(log_data).save()
        if(save_login){
            const user_data = {
                login_id:save_login._id, 
                first_name: req.body.firstName,
                last_name: req.body.lastName,
                Phone_no: req.body.phoneNumber,
                password: req.body.password,
                email: req.body.email,    
                address: req.body.address,    
                gender: req.body.gender,    
                dob: req.body.dob,  
                car_num : req.body.car_num,
                idcard: req.body.idcard, 
                idcardimag: req.body.idcardimag, 
                profilepic: req.body.profilepic, 
            }
            const save_user = await taxiModel(user_data).save()
            if(save_user){
                return res.status(200).json({
                     success:true,
                     error:false,
                     details:save_user,
                     message:"Registration completed"
                 })
             }
        }
       
      
    } catch (error) {
        return res.status(400).json({
            success:true,
            error:false,
            message:"Something went wrong"
        })
    }
})
registerRouter.post('/driverid', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })
  registerRouter.post('/driverprofilepic', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })

registerRouter.post('/driver-register', async function (req, res) {
    try {

        const oldUser = await loginModel.findOne({ username: req.body.username })
        if(oldUser){
           return res.status(400).json({
                success:true,
                error:false,
                message:"User already exist"
            })
        }
        const oldPhone = await driverMOdel.findOne({ Phone_no: req.body.phoneNumber })
        if(oldPhone){
           return res.status(400).json({
                success:true,
                error:false,
                message:"Phone number already exist"
            })
        }

        const log_data = {
            username: req.body.username,
            password: req.body.password,
            role: 3,
            status: 0,
        }
        const save_login = await loginModel(log_data).save()
        if(save_login){
            const user_data = {
                login_id:save_login._id, 
                first_name: req.body.firstName,
                last_name: req.body.lastName,
                Phone_no: req.body.phoneNumber,
                password: req.body.password,
                email: req.body.email,    
                address: req.body.address,    
                gender: req.body.gender,    
                dob: req.body.dob,  
                car_num : req.body.car_num,
                idcard: req.body.idcard, 
                idcardimag: req.body.idcardimag, 
                price: 750,
                profilepic: req.body.profilepic, 
            }
            const save_user = await driverMOdel(user_data).save()
            if(save_user){
                return res.status(200).json({
                     success:true,
                     error:false,
                     details:save_user,
                     message:"Registration completed"
                 })
             }
        }


        
       
      
    } catch (error) {
        return res.status(400).json({
            success:false,
            error:true,
            message:"Something went wrong"
        })
    }
})

registerRouter.get('/approve/:id', async (req, res) => {
    try {
      const id = req.params.id;
 const approve = await loginModel.updateOne({ _id: id }, { $set: { status: 1 } });
   console.log(approve);
      if (approve && approve.modifiedCount === 1) {
        return res.status(200).json({
          success: true,
          message: 'User approved',
        });
      } else if (approve && approve.modifiedCount === 0) {
        return res.status(400).json({
          success: false,
          message: 'User not found or already approved',
        });
      } else {
        throw new Error('Error updating user');
      }
    } catch (error) {
      return res.status(400).json({
        success: false,
        message: 'Something went wrong',
        details: error.message,
      });
    }
  });
  registerRouter.get('/reject/:id', async (req, res) => {
    try {
      const id = req.params.id;
  
      const reject = await loginModel.deleteOne({ _id: id });
  
      if (reject && reject.deletedCount === 1) {
        return res.status(200).json({
          success: true,
          message: 'User rejected',
        });
      } else if (reject && reject.deletedCount === 0) {
        return res.status(400).json({
          success: false,
          message: 'User not found or already rejected',
        });
      } else {
        throw new Error('Error deleting user');
      }
    } catch (error) {
      return res.status(400).json({
        success: false,
        message: 'Something went wrong',
        details: error.message,
      });
    }
  });

  
  registerRouter.get('/viewselect-user/:id', async function (req, res) { 
    try {
        const userId = req.params.id; 
        
console.log(userId);
        const allUser = await userModel.aggregate([
            
            {
                '$lookup': {
                    'from': 'login_tbs',
                    'localField': 'login_id',
                    'foreignField': '_id',
                    'as': 'login'
                }
            },
            {
                '$unwind': "$login"
            },
            {
              '$match': { 'login._id': new objectid (userId) } 
          },
            {
                '$group': {
                    '_id': '$_id',
                    'login_id': { '$first': '$login._id' },
                    'idcard': { '$first': '$idcard' },
                    'first_name': { '$first': '$first_name' },
                    'Phone_no': { '$first': '$Phone_no' },
                    'last_name': { '$first': '$last_name' },
                    'status': { '$first': '$login.status' },
                    'address': { '$first': '$address' },
                    'email': { '$first': '$email' },
                    'gender': { '$first': '$gender' },
                    'username': { '$first': '$login.username' },
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
        ]);

        if (allUser.length === 0) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "No data exist"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: allUser
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});
registerRouter.get('/viewselect-driver/:id', async function (req, res) { 
    try {
        const userId = req.params.id; 
console.log(userId);
        const allUser = await driverMOdel.aggregate([
            
            {
                '$lookup': {
                    'from': 'login_tbs',
                    'localField': 'login_id',
                    'foreignField': '_id',
                    'as': 'login'
                }
            },
            {
                '$unwind': "$login"
            },
            {
              '$match': { 'login._id': new objectid (userId) } 
          },
            {
                '$group': {
                    '_id': '$_id',
                    'login_id': { '$first': '$login._id' },
                    'idcard': { '$first': '$idcard' },
                    'first_name': { '$first': '$first_name' },
                    'Phone_no': { '$first': '$Phone_no' },
                    'last_name': { '$first': '$last_name' },
                    'status': { '$first': '$login.status' },
                    'address': { '$first': '$address' },
                    'email': { '$first': '$email' },
                    'gender': { '$first': '$gender' },
                    'username': { '$first': '$login.username' },
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
        ]);

        if (allUser.length === 0) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "No data exist"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: allUser
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});
registerRouter.get('/viewselect-taxi/:id', async function (req, res) { 
    try {
        const userId = req.params.id; 
console.log(userId);
        const allUser = await taxiModel.aggregate([
            
            {
                '$lookup': {
                    'from': 'login_tbs',
                    'localField': 'login_id',
                    'foreignField': '_id',
                    'as': 'login'
                }
            },
            {
                '$unwind': "$login"
            },
            {
              '$match': { 'login._id': new objectid (userId) } 
          },
            {
                '$group': {
                    '_id': '$_id',
                    'login_id': { '$first': '$login._id' },
                    'idcard': { '$first': '$idcard' },
                    'car_num': { '$first': '$car_num' },
                    'first_name': { '$first': '$first_name' },
                    'Phone_no': { '$first': '$Phone_no' },
                    'last_name': { '$first': '$last_name' },
                    'status': { '$first': '$login.status' },
                    'address': { '$first': '$address' },
                    'email': { '$first': '$email' },
                    'gender': { '$first': '$gender' },
                    'username': { '$first': '$login.username' },
                    'idcardimag':{'$first':'$idcardimag'},
                    'profilepic':{'$first':'$profilepic'},
                }
            }
        ]);

        if (allUser.length === 0) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "No data exist"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: allUser
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});


// registerRouter.get('/view-single-product/:id', async function (req, res) { 
//     try {
//         const productId = req.params.id; 
//         const product = await productModel.findOne({_id:productId})

//         if (!product) { 
//             return res.status(400).json({
//                 success: false,
//                 error: true,
//                 message: "No data exist"
//             });
//         }

//         return res.status(200).json({
//             success: true,
//             error: false,
//             data: product
//         });

//     } catch (error) {
//         return res.status(400).json({
//             success: false,
//             error: true,
//             message: "Something went wrong"
//         });
//     }
// });  
  
// registerRouter.get('/update-single-product/:id', async function (req, res) { 
//     try {
//         const productId = req.params.id; 
//         const details = {
//             product_name : req.body.product_name
//             product_name : req.body.product_name
//             product_name : req.body.product_name
//         }
//         const product = await taxiModel.updateOne({_id:productId},{$set:details})

//         if (product.modifiedCount!=1) { 
//             return res.status(400).json({
//                 success: false,
//                 error: true,
//                 message: "Data not updated"
//             });
//         }

//         return res.status(200).json({
//             success: true,
//             error: false,
//             data: product,
//             message:"Data updated"
//         });

//     } catch (error) {
//         return res.status(400).json({
//             success: false,
//             error: true,
//             message: "Something went wrong"
//         });
//     }
// });  
  
// registerRouter.get('/update-single-product/:id', async function (req, res) { 
//     try {
//         const productId = req.params.id; 
      
//         const product = await taxiModel.deleteOne({_id:productId})

//         if (product.deletedCount!=1) { 
//             return res.status(400).json({
//                 success: false,
//                 error: true,
//                 message: "Data not deleted"
//             });
//         }

//         return res.status(200).json({
//             success: true,
//             error: false,
//             data: product,
//             message:"Data deleted"
//         });

//     } catch (error) {
//         return res.status(400).json({
//             success: false,
//             error: true,
//             message: "Something went wrong"
//         });
//     }
// });  
  

module.exports = registerRouter