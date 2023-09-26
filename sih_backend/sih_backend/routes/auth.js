const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const dotenv = require("dotenv");

dotenv.config();

const UserModel = require("../models/User.js");

const router = express.Router();

router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const user = await UserModel.findOne({ username }).lean();

  if (!user) {
    return res.json({
      message: "user doesn't exist",
    });
  }
  

  if (password!=user.password) {
    return res.json({
      message: "username or password is Incorrect",
    });
  }

  res.json("user logged in");
});

const userRouter = router;
module.exports = userRouter;
