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

exports.e1 = functions.region('asia-east2').https.onRequest((req, res) => {
    sql.connect(config, err=>{
        new sql.Request().query(`SELECT * FROM DIS_REPORT_USER`,(err,result)=>{
            if(err){
                res.send(err);
                console.log(err);
            }else{
                res.send(result);
            }
        });
    })
});

