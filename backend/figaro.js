var requestp = require('request-promise-native');
var fs = require('fs');
const creds = require('./wow.json');
var convert = require('xml-to-json-promise');

function galileo_request(method, path, additional_body)
{
    let tID = makeid();

    let headers = {
        "response-content-type": "application/json",
        "Content-Type":"application/json"
    }

    let body = {
        apiLogin: creds.apiLogin,
        apiTransKey: creds.apiTransKey,
        providerId: creds.providerId,
        prodId: creds.prodId,
        programId: creds.programId,
        transactionId: tID
    }

    let options = {
        header: headers,
        method: method,
        uri: "https://sandbox-api.gpsrv.com/intserv/4.0" + path,
        json: true,
        qs: merge_json(body, additional_body),
        key: fs.readFileSync('./galileo210.pem'),
        cert: fs.readFileSync('./galileo210.pem')
    }

    return new Promise( function(resolve, reject) {
        requestp(options).then(function (response) {
            convert.xmlDataToJSON(response).then(json => {
                resolve(json);
            })
        }).catch(error => console.log(error));
    });
}

function merge_json(obj1, obj2)
{
    var result = {};

    for(var key in obj1) result[key] = obj1[key];
    for(var key in obj2) result[key] = obj2[key];

    return result;
}

function makeid() {
    var text = "";
    var possible = "0123456789";

    for (var i = 0; i < 9; i++)
      text += possible.charAt(Math.floor(Math.random() * possible.length));
  
    return text;
}

module.exports = {
    ping_galileo_service: function () {
        return galileo_request('POST',
        '/ping',
        {})
    },
    create_galileo_account: function () {
        return galileo_request('POST',
        '/createAccount', 
        {})
    },
    get_galileo_account_balance: function (accountNo) {
        return galileo_request('POST',
        '/getBalance',
        {
            accountNo : accountNo
        })
    },
    create_payment: function (accountNo, amount, type = "RL") {
        return galileo_request('POST',
        '/createPayment',
        {
            accountNo: accountNo,
            amount: amount,
            type: type
        })
    },
    transfer_money: function (sourceAcc, transferToAcc, amount) {
        galileo_request('POST', '/createAdjustment',
        {
            accountNo: sourceAcc,
            amount: amount,
            type: "F",
            debitCreditIndicator: "D"
        }).then(result => {
            console.log(JSON.stringify(result))
            galileo_request('POST', "/createPayment",
            {
                accountNo: transferToAcc,
                amount: amount,
                type: "RL"
            }).then(r2 => {
                console.log(JSON.stringify(r2))
            })
        })
    }
    // ,
    // merge_json: function(obj1, obj2)
    // {
    //     var result = {};
    
    //     for(var key in obj1) result[key] = obj1[key];
    //     for(var key in obj2) result[key] = obj2[key];
    
    //     return result;
    // }
}


// console.log(module.exports.transfer_money(999900091557, 999900091565, 1))

// module.exports.get_galileo_account_balance(999900091565).then(res => {
//         convert.xmlDataToJSON(res).then(json => {
//             console.log(json.response.response_data[0].balance[0]);
//         });
//     });

// module.exports.create_payment(999900091565, 100.00).then(res => {
//         convert.xmlDataToJSON(res).then(json => {
//             console.log(JSON.stringify(json));
//         });
//     });

// module.exports.create_galileo_account().then(res => {
//     convert.xmlDataToJSON(res).then(json => {
//         console.log(json.response.response_data[0].new_account[0].pmt_ref_no[0]);
//     });
// });

// module.exports.ping_galileo_service().then(res => {
//         console.log(res.response);//.response_data[0].new_account[0].pmt_ref_no);
// });

// parseString(module.exports.ping_galileo_service(), function (err, result) {
//     console.dir(result);
// });