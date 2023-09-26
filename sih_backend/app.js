import dotenv from "dotenv";
dotenv.config();
import express from "express";
import connectDB from "./db/connect.js";

const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.get('/', (req,res)=>{
    res.send("Hi I am live");
});

const start = async ()=>{
    try{
        await connectDB(process.env.MONGODB_URL);
        app.listen(PORT,()=>{
            console.log("Example app listening on http://localhost:%s",PORT);
        });
    }
    catch(err){
        console.log(err)
    }
};
start();