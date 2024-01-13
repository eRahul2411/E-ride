const express = require('express')
const loginModel = require('../Models/loginModel')

const userModel = require('../models/userModel')
const driverModel = require('../models/driverModel')
const taxiModel = require('../models/taxiModel')

const loginRouter = express.Router()


loginRouter.post('/login', async (req, res) => {
    try {
        const oldUser = await loginModel.findOne({ username: req.body.username })
        if (!oldUser) {
            return res.status(400).json({
                success: false,
                error: true,
                message: "User not found !"
            })
        }
        if (oldUser.password == req.body.password) {
            if (oldUser.role == 0) {
                return res.status(200).json({
                    success: true,
                    error: false,
                    login_id: oldUser._id,
                    details: oldUser,
                    status: oldUser.status,
                })
            }
            if (oldUser.role == 1) {
                const user = await userModel.findOne({ login_id: oldUser._id })
                if (user) {
                    return res.status(200).json({
                        success: true,
                        error: false,
                        login_id: oldUser._id,
                        user_id: user._id,
                        status: oldUser.status,
                        details: oldUser
                    })
                }

            }
            if (oldUser.role == 2) {
                const taxi = await taxiModel.findOne({ login_id: oldUser._id })
                if (taxi) {
                    return res.status(200).json({
                        success: true,
                        error: false,
                        login_id: oldUser._id,
                        taxi_id: taxi._id,
                        status: oldUser.status,
                        details: oldUser
                    })
                }

            }
            if (oldUser.role == 3) {
                const driver = await driverModel.findOne({ login_id: oldUser._id })
                if (driver) {
                    return res.status(200).json({
                        success: true,
                        error: false,
                        login_id: oldUser._id,
                        driver_id: driver._id,
                        status: oldUser.status,
                        details: oldUser
                    })
                }

            }
            

        } else {
            return res.status(406).json({
                success: false,
                error: true,
                message: "Password not matching!"
            })
        }


    } catch (error) {
         return res.status(400).json({
            success:true,
            error:false,
            message:"Something went wrong"
        })

    }
})

module.exports = loginRouter