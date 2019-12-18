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
            if (result.recordset.length > 0) {
                res.json(result.recordset[0]['USER_ID']);
            } else {
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
    request.query(sqlCode, (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.json(result.recordset);
        }
    });
});

server.get("/getCountryList", (req, res) => {
    let request = new sql.Request();
    request.query("SELECT COUNTRY_ID, COUNTRY_NAME FROM COUNTRY_MASTER", (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        res.json(result.recordset);
    });
});

server.get("/getCompanyName", (req, res) => {
    let companyId = req.query.companyId;
    let request = new sql.Request();
    request.query(`SELECT COMPANY_NAME FROM COMPANY WHERE COMPANY_ID = ${companyId}`, (err, result) => {
        res.send(result.recordset[0]['COMPANY_NAME']);
    });

});

server.get('/getStatusList', (req, res) => {
    let request = new sql.Request();
    request.query(`SELECT * FROM SALE_STATUS`, (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        res.json(result.recordset);
    });
});

server.get('/getEmployeeName', (req, res) => {
    let request = new sql.Request();
    request.query(`SELECT SHORT_NAME FROM DIS_REPORT_USER`, (err, result) => {
        res.json(result.recordset);
    });
});

server.get("/getCompanyInfo", (req, res) => {
    let companyId = req.query.companyId;
    let request = new sql.Request();
    request.query(`select COMPANY.COMPANY_ID, COMPANY.COMPANY_NAME,COMPANY.TEL_NO,COMPANY.CONTACT_POINT,COMPANY.ADDRESS,COUNTRY_MASTER.COUNTRY_ID,COUNTRY_MASTER.COUNTRY_NAME, PROVINCE_MASTER.PROVINCE_ID,PROVINCE_MASTER.PROVINCE_NAME,DISTRICT_MASTER.DISTRICT_ID,DISTRICT_MASTER.DISTRICT_NAME from COMPANY
                LEFT JOIN COUNTRY_MASTER on COUNTRY_MASTER.COUNTRY_ID = COMPANY.COUNTRY_ID
                LEFT JOIN PROVINCE_MASTER on PROVINCE_MASTER.PROVINCE_ID = COMPANY.PROVINCE_ID
                LEFT JOIN DISTRICT_MASTER on DISTRICT_MASTER.DISTRICT_ID = COMPANY.DISTRICT_ID 
                where COMPANY_ID = ${companyId}`, (err, result) => {
        res.json(result.recordset);
    });
});

server.get("/getProvinceList", (req, res) => {
    let countryId = req.query.countryId;
    let request = new sql.Request();
    request.query(`SELECT PROVINCE_ID, PROVINCE_NAME FROM PROVINCE_MASTER WHERE COUNTRY_ID = ${countryId}`, (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        res.json(result.recordset);
    });
});

server.get("/getDistrictList", (req, res) => {
    let provinceId = req.query.provinceId;
    let request = new sql.Request();
    request.query(`SELECT DISTRICT_ID, DISTRICT_NAME FROM DISTRICT_MASTER WHERE PROVINCE_ID = ${provinceId}`, (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        res.json(result.recordset);
    });
});


server.post("/updateCompanyProspect", (req, res) => {
    let userId = req.body.userId;
    let companyId = req.body.companyId;
    let dealPercent = req.body.dealPercent;
    let expectedRev = req.body.expectedRev;

    let userName;

    let request = new sql.Request();

    request.query(`select * from DIS_REPORT_USER where DIS_REPORT_USER.USER_ID like '${userId}'`, (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        userName = result.recordset[0]['SHORT_NAME'];
        request.query(`SELECT * FROM DIS_REPORT_COMPANY_MAPPING WHERE COMPANY_ID = ${companyId}`, (err, result2) => {
            if (err) {
                console.log(err);
                return;
            }
            if (result2.recordset.length == 0) {
                request.query(`INSERT INTO DIS_REPORT_COMPANY_MAPPING(COMPANY_ID, EXPECTED_REVENUE, CLOSE_DEAL_PERCENTAGE,UPDATE_SALE_STATUS_BY)
                            VALUES(${companyId},'${expectedRev}','${dealPercent}','${userName}')`, (err, result3) => {
                    res.send('1');
                });
            } else {
                request.query(`UPDATE DIS_REPORT_COMPANY_MAPPING
                            SET EXPECTED_REVENUE='${expectedRev}',CLOSE_DEAL_PERCENTAGE='${dealPercent}',UPDATE_SALE_STATUS_BY = '${userName}'
                            WHERE COMPANY_ID = ${companyId};`, (err, result3) => {
                    res.send('1');
                });
            }
        });

    });
});

server.post("/updateCompanyInfo", (req, res) => {
    let contact_point = req.body.contact_point;
    let tel = req.body.tel;
    let address = req.body.address;
    let countryId = req.body.countryId;
    let provinceId = req.body.provinceId;
    let districtId = req.body.districtId;
    let userId = req.body.userId;
    let companyId = req.body.companyId;
    let userName;
    let request = new sql.Request();

    request.query(`select * from DIS_REPORT_USER where DIS_REPORT_USER.USER_ID like '${userId}'`, (err, result) => {
        if (err) {
            console.log(err);
            return;
        }
        userName = result.recordset[0]['SHORT_NAME'];
        request.query(`UPDATE COMPANY
            SET CONTACT_POINT = '${contact_point}', TEL_NO = '${tel}', ADDRESS = '${address}', COUNTRY_ID = ${countryId},PROVINCE_ID = ${provinceId}, DISTRICT_ID = ${districtId}, UPDATE_SALE_STATUS_BY = '${userName}'
            WHERE COMPANY_ID = ${companyId}`,(err,result2)=>{
            res.send('1');
        });
    })
});

server.post("/updateCompanyProgress", (req, res) => {
    let datetime = req.body.datetime;
    let status = req.body.status;
    let note = req.body.note;
    let sale_name = req.body.sale_name;
    let created_by = req.body.created_by;
    let companyName = req.body.companyName;
    let userName;
    let request = new sql.Request();

    request.query(`SELECT SHORT_NAME FROM DIS_REPORT_USER WHERE USER_ID = ${created_by}`, (req, result) => {
        userName = result.recordset[0]['SHORT_NAME'];

        request.query(`SELECT TOP 1 CONVERT(varchar,CREATE_DATE,20) as CREATE_DATE FROM SALE_HISTORY_BY_COMPANY
                    WHERE COMPANY_NAME like '${companyName}'
                    ORDER BY CREATE_DATE`, (err, result1) => {
            if (result1.recordset.length == 0) {
                request.query(`INSERT INTO SALE_HISTORY_BY_COMPANY
                         VALUES('${sale_name}','${companyName}','${datetime}','${status}','${note}','${dateFormat(new Date(),"yyyy-mm-dd HH:MM:00")}','${userName}')`, (err, result2) => {
                    if (err) {
                        console.log(err);
                        return;
                    }
                });
            } else {
                let create_date = result1.recordset[0]['CREATE_DATE'];
                console.log(create_date);
                console.log(`INSERT INTO SALE_HISTORY_BY_COMPANY
                VALUES('${sale_name}','${companyName}','${datetime}','${status}','${note}','${create_date}','${userName}')`);
                request.query(`INSERT INTO SALE_HISTORY_BY_COMPANY
                         VALUES('${sale_name}','${companyName}','${datetime}','${status}','${note}','${create_date}','${userName}')`, (err, result2) => {
                    if (err) {
                        console.log(err);
                        return;
                    }
                });
            }
        });
    });
    res.send('1');
});

server.get("/getUserInfo",(req,res)=>{
    let userId = req.query.userId;
    let request = new sql.Request();
    request.query(`SELECT SHORT_NAME FROM DIS_REPORT_USER WHERE USER_ID = ${userId}`,(err, result)=>{
        res.send(result.recordset[0]['SHORT_NAME']);
    });
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