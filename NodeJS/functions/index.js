const functions = require('firebase-functions');
const sql = require('mssql');
const crypto = require('crypto');
const dateFormat = require('dateformat');

var config = {
    user: 'devattest',
    password: 'ig]balF9o',
    server: 'ddu0d6m5ky.database.windows.net',
    database: 'StoneLab',
    options: {
        encrypt: true
    }
};

exports.e1 = functions.region('asia-east2').https.onRequest(async(req, res) => {
    // await sql.connect(config)
    // const result = await sql.query(`SELECT * FROM DIS_REPORT_USER`);
    // res.send(result);
    // console.log(result);
    await sql.connect(config, (err) => {
        if (err) {
            console.log(err);
        } else {
            console.log("Database Connected");
        }
        let request = new sql.Request();
        request.query('SELECT * FROM DIS_REPORT_USER',(err,result)=>{
            if(err){
                res.send(err);
            }else{
                res.send(result);
            }
        })
    });
});

