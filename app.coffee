
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
contact = require("./routes/contact")
http = require("http")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# HTML should be prettified
app.locals.pretty = true

# https://github.com/adunkman/connect-assets/issues/221
app.use require("connect-assets")(buildDir: "public", helperContext: app.locals)

app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser("your secret here")
app.use express.session()
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.get "/about", user.list
app.get "/contact", contact.list
app.post "/contact", contact.form
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
