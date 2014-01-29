
#
# * GET contact page.
#
exports.list = (req, res) ->
  res.locals.path = req.path
  res.render "contact"

exports.form = (req, res) ->
  name = req.body.name
  email = req.body.email
  comment = req.body.comment

  nodemailer = require("nodemailer")

  # create reusable transport method (opens pool of SMTP connections)
  smtpTransport = nodemailer.createTransport("SMTP",
    service: "Gmail"
    auth:
      user: "hanadevel@gmail.com"
      pass: "password"
  )

  # setup e-mail data with unicode symbols
  mailOptions =
    from: "Elmer Mendoza <defreddyelmer@gmail.com>" # sender address
    to: "hanadevel@gmail.com" # list of receivers
    subject: "Contact Website" # Subject line
    text: "Hello world ✔" # plaintext body
    html: "<b>Hello world ✔</b>" # html body


  # send mail with defined transport object
  smtpTransport.sendMail mailOptions, (error, response) ->
    if error
      console.log error
    else
      console.log "Message sent: " + response.message

  # if you don't want to use this transport object anymore, uncomment following line
  smtpTransport.close(); # shut down the connection pool, no more messages

  res.locals.path = req.path
  res.json(req.body)
