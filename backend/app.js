var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var app = express();
var figaro = require("./figaro")

var secret = require('./streetcred.json');

var con = mysql.createConnection({
  host: "206.189.167.176",
  port: "3306",
  user: "pitcher",
  password: secret.password,
  database: "Pitcher"
});

var connection = con.connect(function(err){
 if (err) throw err;
 console.log("Connected!");
})

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json
app.use(bodyParser.json())

app.listen(8080, () => console.log('server running'))

app.get('/', (req, res) => res.send('It\'s a good day to die!'));

// USERS ---------------------------------------------------------------------------
// /users endpoint
app.get('/users', function (req, res) {
  query = `Select *	FROM USERS`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    }
    else
    {
      res.send(result)
    }
  })
})

app.post('/users', function (req, res) {
  try {
    figaro.create_galileo_account().then(result => {
      let body = req.body;
      let id = result.response.response_data[0].new_account[0].pmt_ref_no[0];
      query = `INSERT INTO \`USERS\` (\`ID\`, \`USERNAME\`, \`PASSWORD\`, \`FIRSTNAME\`, \`LASTNAME\`) VALUES ('${id}', '${body.USERNAME}', '${body.PASSWORD}', '${body.FIRSTNAME}', '${body.LASTNAME}')`
      // res.send(query)
      con.query(query, function (err, result, fields) {
        if (err)
        {
          res.status(400)
          res.send("Invalid Request: \n" + err)
        } else {
          res.send(body);
        }
      })
    })
  }
  catch(err) {
    console.log(err);
    res.status(500);
    res.send("Internal Server Error")
  }
  // query = INSERT INTO `USERS`(`ID`, `USERNAME`, `PASSWORD`, `FIRSTNAME`, `LASTNAME`) VALUES ([value-1],[value-2],[value-3],[value-4],[value-5])
})

// /users/:id
app.get('/users/:id', function (req, res) {
  var id = req.params.id;
  query = `SELECT ID, USERNAME, FIRSTNAME, LASTNAME FROM USERS WHERE ID=${id}`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

app.delete('/users/:id', function (req, res) {
  var id = req.params.id;
  query = `DELETE FROM USERS WHERE ID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else
    {
      if(result.changedRows > 0)
      {
        res.status(200);
        res.send(result);
      } else
      {
        res.status(304);
        res.send("Nothing Changed");
      }
      
    }
  })
})

app.put('/users/:id', function (req, res) {
  let body = req.body;
  var id = req.params.id
  query = `UPDATE USERS SET USERNAME ="${body.USERNAME}", FIRSTNAME ="${body.FIRSTNAME}", LASTNAME ="${body.LASTNAME}" WHERE ID = ${id}`
  console.log(query)
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})

// TODO
// /users/:user_id/contributions
app.get('/users/:user_id/contributions', function (req, res) {
  var id = req.params.user_id
  query = `SELECT * FROM CONTRIBUTIONS WHERE ID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

// /users/:user_id/contributions/:contribution_id
app.get('/users/:user_id/contributions/:contribution_id', function (req, res) {
  var user_id = req.params.user_id
  var contribution_id = req.params.contribution_id
  query = `SELECT * FROM CONTRIBUTIONS WHERE ID = ${user_id}, TID = ${contribution_id}`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

app.get('/users/:user_id/balance', function (req, res) {
  var user_id = req.params.user_id;
  figaro.get_galileo_account_balance(user_id).then(json => {
    try {
      console.log(JSON.stringify(json));
      if(json.response.response_data[0] == "")
      {
        res.send("0");
      } else
      {
        res.send(json.response.response_data[0].balance[0]);
      }
    } catch (err)
    {
      res.status(400);
      res.send("Error:\n" + err);
    }
  });
});
// USERS ---------------------------------------------------------------------------


// POOLS ---------------------------------------------------------------------------
// /pools
app.get('/pools', function (req, res) {
  query = `SELECT * FROM POOLS`;
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

app.post('/pools', function (req, res) {
  figaro.create_galileo_account().then(result => {
    let id = result.response.response_data[0].new_account[0].pmt_ref_no[0];
    let body = req.body;
    // TODO: complete should be calculated by business logic, not allowed to be posted
    query = `INSERT INTO POOLS (PID, NAME, EVENTDATE, PAYMENTDATE, TYPE, COMPLETE, COST) VALUES ("${id}", "${body.NAME}", "${body.EVENTDATE}", "${body.PAYMENTDATE}", "${body.TYPE}", "${body.COMPLETE}", "${body.COST}")`;
    con.query(query, function (err, result, fields) {
      if (err)
      {
        res.status(400)
        res.send("Invalid Request: \n" + err)
      } else {
        res.send({
          "ID": id
        });
      }
    })
  })
})

// /pools/:id
app.get('/pools/:id', function (req, res) {
  var id = req.params.id
  query = `SELECT * FROM POOLS WHERE PID = "${id}"`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

app.delete('/pools/:id', function (req, res) {
  var id = req.params.id
  query = `DELETE FROM POOLS WHERE PID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(result);
    }
  })
})

app.post('/login', function (req, res)
{
  body = req.body
  query = `SELECT ID FROM USERS WHERE USERNAME = "${body.USERNAME}" AND PASSWORD = "${body.PASSWORD}"`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(result);
    }
  })
});
// function update_query_builder(body, table_name, key_column, cols_to_check)
// {
//   console.log(body)
//   if (typeof body[key_column] == 'undefined')
//   {
//     return ""
//   }

//   cols_update_count = 0

//   cols_to_update = []

//   cols_to_check.forEach((x) => {
//     if (typeof body[x] != 'undefined')
//     {
//       cols_to_update += x
//       col_update_count += 1
//     }
//   })

//   update_query = `UPDATE ${table_name} SET `

//   if (cols_update_count >= 1)
//   {
//     update_query += `${cols_to_update[0]} = ${body[cols_to_update[0]]}`
//   }

//   if (cols_update_count > 1)
//   {
//     for(i = 1; i < cols_to_update.length; i++)
//     {
//       update_query += `, ${cols_to_update[i]} = ${body[cols_to_update[i]]}`
//     }
    
//   }

//   update_query += ` where ${key_column}=${body[key_column]}`


//   console.log(update_query)

//   return update_query
// }

app.put('/pools/:id', function (req, res) {
  let body = req.body;
  var id = req.params.id

  if (req.body == {})
  {
    res.status(400)
    res.send("Invalid Request, no variables specified for update")
  }

  body = figaro.merge_json(body, {
    "PID": req.params.id
  })

  query =  update_query_builder(body, "POOLS", "PID", ["EVENTDATE", "PAYMENTDATE", "TYPE", "COMPLETE"])

  // query = `UPDATE POOLS SET EVENTDATE = "${body.EVENTDATE}", PAYMENTDATE = "${body.PAYMENTDATE}", TYPE = "${body.TYPE}", COMPLETE = "${body.COMPLETE}" where PID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})

// /pools/:id/contributions
app.get('/pools/:id/contributions', function (req, res) {
  var id = req.params.id
  query = `SELECT FIRSTNAME FROM CONTRIBUTIONS JOIN USERS on USERS.ID = CONTRIBUTIONS.ID WHERE CONTRIBUTIONS.TID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})
// POOLS ---------------------------------------------------------------------------

// CONTRIBUTIONS ---------------------------------------------------------------------------
// /contributions
app.get('/contributions', function (req, res) {
  query = `SELECT * FROM CONTRIBUTIONS`;
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

app.post('/contributions', function (req, res) {
  let body = req.body;

  query = `INSERT INTO CONTRIBUTIONS (ID, PID, CONTRIBUTION) VALUES ("${body.ID}", "${body.PID}", "${body.CONTRIBUTION}")`;
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})

// /contributions/:id
app.get('/contributions/:id', function (req, res) {
  var id = req.params.id
  query = `SELECT * FROM CONTRIBUTIONS WHERE TID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  })
})

// FIGURE THIS ONE OUT (2 primary keys bad!)
app.delete('/contributions/:id', function (req, res) {
  var id = req.params.id
  query = `DELETE FROM CONTRIBUTIONS WHERE ID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(result);
    }
  })
})

app.put('/contributions/:id', function (req, res) {
  var id = req.params.id
  let body = req.body;
  query = `UPDATE CONTRIBUTIONS SET CONTRIBUTION = \`${body.CONTRIBUTION}\` where ID = \`${body.ID}\` and PID = \`${body.PID}\`;`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})
// CONTRIBUTIONS ---------------------------------------------------------------------------

// app.post('/scott', function (req, res) {
//   console.log(req.body);
//   res.setHeader('Content-Type', 'application/json');
//   res.send(req.body);
// })

app.get('/invites/:id', function (req, res) {
  let id = req.params.id;
  query = `SELECT * FROM INVITES WHERE ID = ${id}`
  con.query(query, function (err, result, fields)  {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})

app.post('/invites', function (req, res) {
  let body = req.body;

  query = `INSERT INTO INVITE ("PID", "ID") VALUES ("${body.PID}", "${body.ID}")`;
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(body);
    }
  })
})

app.delete('/contributions/:user_id', function (req, res) {
  var id = req.params.id
  query = `DELETE FROM ITEMS WHERE ID = ${id}`
  con.query(query, function (err, result, fields) {
    if (err)
    {
      res.status(400)
      res.send("Invalid Request: \n" + err)
    } else {
      res.send(result);
    }
  })
})












