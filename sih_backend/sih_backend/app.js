const dotenv = require("dotenv");
const express = require("express");
const connectDB = require("./db/connect.js");
const userRouter = require("./routes/auth.js");
const regRouter = require("./routes/regorg.js");
const cors = require("cors");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cors());

app.use("/auth", userRouter);
app.use("/reg", regRouter);



const start = async () => {
  try {
    await connectDB(process.env.MONGODB_URL);
    app.listen(PORT, () => {
      console.log("app listening on http://localhost:%s", PORT);
    });
  } catch (err) {
    console.log(err);
  }
};
start();
