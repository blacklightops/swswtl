# Get XMPP
xmpp = require('node-xmpp')

room_jid = "ops@conference.xmpp.blacklightops.com"
room_nick = "Node Bot"

client = new xmpp.Client({
  jid: 'blacklight4@xmpp.blacklightops.com/node'
  password: 'foobar5'
  preferredSaslMechanism: 'PLAIN' 
})

client.on 'online', () ->
  console.log 'Connected to the jabber server'

  client.send new xmpp.Element('presence', {type: 'available' }).c('show').t('chat')
  client.send new xmpp.Element('presence', {to: room_jid + '/' + room_nick}).c('x', {xmlns: 'http://jabber.org/protocol/muc' })
  
    
client.on 'stanza', (stanza) ->
  if stanza.is('message') and (stanza.attrs.type != 'error')
    # Swap addresses...
    stanza.attrs.to = stanza.attrs.from
    delete stanza.attrs.from
    # and send back
    console.log('Sending response: ' + stanza.root().toString())
    client.send(stanza)
    
module.exports = client