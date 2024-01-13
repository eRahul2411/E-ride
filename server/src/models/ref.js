const express = require('express');
const loginModel = require('../models/loginModel');
const productModel = require('../models/ProductModel');
const multer = require('multer');
const qr = require('qr-image');
const fs = require('fs');
const productRouter = express.Router();

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "./public/images/")
    },
    filename: function (req, file, cb) {
        cb(null,file.originalname)
    }
  })
  
  var upload = multer({ storage: storage })

  productRouter.post('/upload', upload.single("file"), (req, res) => {
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
  })
productRouter.get('/view-product', async (req, res) => {
  try {
      const users = await productModel.find()
      if(users[0]!=undefined){
          return res.status(200).json({
              success:true,
              error:false,
              data:users
          })
      }else{
          return res.status(400).json({
              success:false,
              error:true,
              message:"No data found"
          })
      }
  } catch (error) {
      return res.status(400).json({
          success:false,
          error:true,
          message:"Something went wrong",
          details:error
      })
  }
  })
  
productRouter.post('/product', async function (req, res) {
  try {
    const data = {
        product_name: req.body. product_name ,
        quantity: req.body.quantity,
        price: req.body.price,
        description: req.body.description,
        category: req.body.category, 
      product_image:req.body.product_image,
      
    };
    const datas = await productModel(data).save()
    console.log(datas);
    if (datas) {
        if (datas) {
            const qrCode = qr.image(JSON.stringify(datas._id), { type: 'png' });
            const qrCodeFilePath = `public/qrcodes/${datas.product_name}.png`;
              const qrCodeFile = fs.createWriteStream(qrCodeFilePath);
              qrCode.pipe(qrCodeFile);
              qrCodeFile.on('finish', () => {
                console.log('QR code generated and saved');
                // Send the response with the QR code file path
                return res.status(200).json({
                    success: true,
                    error: false,
                    details: datas,
                    message: "item added completed"
                })
              });
           
        }
      
  }
    
  } catch (error) {
    return res.status(400).json({
      success: false,
      error: true,
      message: "somethig wet wrog"
  })
  }
});


productRouter.get('/view-single-product/:id', async function (req, res) { 
    try {
        const productId = req.params.id; 
        const product = await productModel.findOne({_id:productId})

        if (!product) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "No data exist"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: product
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});  
  
productRouter.post('/update-single-product/:id', async function (req, res) { 
    try {
        const productId = req.params.id; 
        const details = {
            product_name : req.body.product_name,
            quantity : req.body.quantity,
            category : req.body. category,
            description : req.body. description,
            product_image : req.body.product_image
        }
        const product = await productModel.updateOne({_id:productId},{$set:details})

        if (product.modifiedCount!=1) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "Data not updated"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: product,
            message:"Data updated"
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});  
  
productRouter.post('/delete-single-product/:id', async function (req, res) { 
    try {
        const productId = req.params.id; 
      
        const product = await productModel.deleteOne({_id:productId})

        if (product.deletedCount!=1) { 
            return res.status(400).json({
                success: false,
                error: true,
                message: "Data not deleted"
            });
        }

        return res.status(200).json({
            success: true,
            error: false,
            data: product,
            message:"Data deleted"
        });

    } catch (error) {
        return res.status(400).json({
            success: false,
            error: true,
            message: "Something went wrong"
        });
    }
});
module.exports = productRouter;