client = require('../messaging')
xmpp = require('node-xmpp')

# Simply render the index template
module.exports = (req, res) ->
  console.log req.body.message  
  client.send new xmpp.Element('message', {to: "ops@conference.xmpp.blacklightops.com", type: 'groupchat'}).c('body').t(req.body.message)