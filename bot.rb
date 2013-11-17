#!/usr/bin/env ruby

require 'rubygems' #if RUBY_VERSION < '1.9.0'
#require 'sensu-handler'
require 'xmpp4r/client'
require 'xmpp4r/muc'
include Jabber
require 'json'

severity = ['Emergency','Alert','Critical','Error','Warning','Notice','Informational','Debug']
type = ['alert', 'recovery','event']
hostname = ['marvin', 'gemsbok', 'optimus', 'monet', 'proxima', 'kenobi']


xmpp_jid = 'blacklight3@xmpp.blacklightops.com'
xmpp_password = 'foobar5'
xmpp_target = 'monitoring@conference.xmpp.blacklightops.com'
xmpp_target_type = 'conference'
xmpp_server = 'xmpp.blacklightops.com '

jid = JID.new(xmpp_jid)
cl = Client.new(jid)
cl::allow_tls = false
cl.connect(xmpp_server, 5222)
cl.auth(xmpp_password)
cl.send(Jabber::Presence.new.set_show(:chat).set_status('Monitor all the things!'))
room = MUC::MUCClient.new(cl)
room.join(Jabber::JID.new(xmpp_target+'/'+cl.jid.node))

while true:
  msg = Message::new(xmpp_jid)
  msg.type=:chat

  #log = {}
  #log['severity'] = severity[rand(severity.length)]
  #log['type'] = type[rand(type.length)]
  #log['description'] = "blah"
  #log['hostname'] = hostname[rand(hostname.length)]
  #log['timestamp'] = Time.now().to_i
  #log = "#{type[rand(type.length)]} #{severity[rand(severity.length)]} #{hostname[rand(hostname.length)]}"
  t = type[rand(type.length)]
  if t == 'alert'
    color = 'red'
  elsif t == 'recovery'
    color = 'green'
  else
    color = 'black'
  end

  log = "<b><font color=\"#{color}\">#{t}</font> #{severity[rand(severity.length)]}</b><br /><pre>     Hostname: #{hostname[rand(hostname.length)]}</pre>"

  #msg.body = log #JSON.dump(log)
  msg.set_xhtml_body(log)

  room.send msg
  sleep(1)
end
cl.close
room.exit
