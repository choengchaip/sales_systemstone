const express = require('express');
const sql = require('mssql');
const server = express();
const crypto = require('crypto');
const bodyParser = require('body-parser');
const dateFormat = require('dateformat');

server.use(bodyParser());

var config = {
    user: 'devattest',
    password: 'ig]balF9o',
    server: 'ddu0d6m5ky.database.windows.net',
    database: 'StoneLab',
    options: {
        encrypt: true
    }
};


server.post("/auth", async (req, res) => {
    let username = req.body.username;
    let password = req.body.password;
    password = crypto.createHash('sha256').update(password).digest('hex');
    let request = new sql.Request();
    request.query(`select * from DIS_REPORT_USER where (DIS_REPORT_USER.USER_NAME like '${username}') and (DIS_REPORT_USER.PASSWORD like '${password}')`, (err, result) => {
        if (err) {
            console.log(err);
        } else {
            if(result.recordset.length > 0){
                res.json(result.recordset[0]['USER_ID']);
            }else{
                res.send('0');
            }
        }
    });
});

server.get("/getCompanyList", (req, res) => {
    let userId = req.query.userId;
    let companyName = req.query.companyName;
    var sqlCode = `SELECT * FROM COMPANY
                WHERE (COMPANY.DISTRIBUTOR_ID = (SELECT DIS_REPORT_USER.DISTRIBUTOR_ID from DIS_REPORT_USER WHERE DIS_REPORT_USER.USER_ID = ${userId}) or COMPANY.EVENT like (SELECT DISTRIBUTOR.NAME FROM DISTRIBUTOR WHERE DISTRIBUTOR.ID = (SELECT DIS_REPORT_USER.DISTRIBUTOR_ID from DIS_REPORT_USER WHERE DIS_REPORT_USER.USER_ID =${userId}))) and COMPANY.COMPANY_NAME like '%${companyName}%'
                `;  
    let request = new sql.Request();
    request.query(sqlCode,(err,result)=>{
        if(err){
            console.log(err);
        }else{
            res.json(result.recordset);
        }
    });
});

server.get("/getCompanyInfo", (req, res) => {

});

server.get("/getCompanyProgress", (req, res) => {

});

server.post("/updateCompanyProspect", (req, res) => {
    let userId = req.body.userId;
    let companyId = req.body.companyId;
    let dealPercent = req.body.dealPercent;
    let expectedRev = req.body.expectedRev;

    let userName;
    let companyName;

    let request = new sql.Request();
    
        request.query(`select * from DIS_REPORT_USER where DIS_REPORT_USER.USER_ID like '${userId}'`,(err,result)=>{
            if(err){
             console.log(err);
             return;
            }
                userName = result.recordset[0]['SHORT_NAME'];
                request.query(`select * from COMPANY where COMPANY.COMPANY_ID = ${companyId}`,(err,result1)=>{
                    if(err){
                        console.log(err);
                        return;
                    }
                    companyName = result1.recordset[0]['COMPANY_NAME'];
                    console.log(userName);
                    console.log(companyName);
                    console.log(dealPercent);
                    console.log(expectedRev);
                    console.log(dateFormat(new Date(), 'yyyy-mm-dd hh:MM:ss'));

                    request.query(`select * from SALE_HISTORY_BY_COMPANY where SALE_NAME like '${userName}' and COMPANY_NAME like '${companyName}'`,(err, result2)=>{
                        if(result2.recordset.length>0){
                            console.log('1');
                            request.query(`UPDATE SALE_HISTORY_BY_COMPANY
                                SET EXPECTED_REVENUE = ${dealPercent}, CLOSE_DEAL_PERCENTAGE = ${expectedRev}
                                WHERE (SALE_NAME like '${userName}') and (COMPANY_NAME like '${companyName}') and (ACTIVITY_DATE = (SELECT TOP 1 ACTIVITY_DATE FROM SALE_HISTORY_BY_COMPANY where (SALE_NAME like '${userName}') and (COMPANY_NAME like '${companyName}') ORDER BY ACTIVITY_DATE DESC));
                                `,(err, result3)=>{
                                res.send('1');
                            });
                        }else{
                            console.log('2');
                            request.query(`INSERT INTO SALE_HISTORY_BY_COMPANY(SALE_NAME, COMPANY_NAME, ACTIVITY_DATE,EXPECTED_REVENUE,CLOSE_DEAL_PERCENTAGE,CREATE_DATE,CREATE_BY)
                                VALUES('${userName}','${companyName}','${dateFormat(new Date(), 'yyyy-mm-dd hh:MM:ss')}', ${expectedRev},${dealPercent},'${dateFormat(new Date(), 'yyyy-mm-dd hh:MM:ss')}','${userName}');`,(err, result4)=>{
                                res.send('1');
                            });
                        }
                    });

                });
        
    });
});

server.post("/updateCompanyInfo", (req, res) => {

});

server.post("/updateCompanyProgress", (req, res) => {

});

server.listen(8750, (req, res) => {
    console.log("Server is Running ...");
    sql.connect(config, (err) => {
        if (err) {
            console.log(err);
        } else {
            console.log("Database Connected");
        }
    });
});
