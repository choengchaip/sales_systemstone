const sql = require('mssql');
const crypto = require('crypto');
const express = require('express');
const dateFormat = require('dateformat');
const app = express();

var config = {
    user: 'devattest',
    password: 'ig]balF9o',
    server: 'ddu0d6m5ky.database.windows.net',
    database: 'StoneLab',
    options: {
        encrypt: true
    }
};


app.get("/",async(req,res)=>{
    await sql.connect(config)
    const result = await sql.query(`SELECT * FROM DIS_REPORT_USER`);
    console.log(result);
})

app.listen(8750,(req,res)=>{
    console.log("RUnning");
})

