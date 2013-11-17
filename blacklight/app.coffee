#
#  Module dependencies.
#
require('coffee-script')
coffeescript = require('connect-coffee-script')
express = require('express')
http = require('http')
path = require('path')
fs = require('fs')
index = require('./controllers')
messageController = require('./controllers/message')
app = express()

app.configure () ->
  app.set('port', process.env.PORT || 8980)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.compress())
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('your secret here'))
  app.use(express.cookieSession())
  app.use(app.router)
  app.use(require('stylus').middleware({
    src: __dirname + "/resources"
    dest: __dirname + "/public"
    compress: true
    debug: true
  }))

  app.use(coffeescript({
    src: __dirname + "/resources"
    dest: __dirname + "/public"
    sourceMap: true
  }))


  app.use(express.static(path.join(__dirname, 'public')))

  # Setup local variables to be available in the views.
  app.locals.app_name = "Black Light Ops"
  app.locals.title = "Black Light Ops"
  app.locals.description = "Ops made easy."
  app.locals.node_version = process.version.replace('v', '')
  app.locals.app_version = require('./package.json').version
  app.locals.env = process.env.NODE_ENV
  app.post('/message', messageController);
  app.get('/', index)


app.configure('development', () ->
  app.use(express.errorHandler())
)


http.createServer(app).listen app.get('port'), () ->
  console.log("Express server listening on port " + app.get('port'))
  console.log("\nhttp://localhost:" + app.get('port') + "\n")