<?php
/**
 * @package Jabber/XMPP XML-RPC Authentication
 * @author James Holding
 * @version 1.0
 **/
/*
Plugin Name: Jabber/XMPP XML-RPC Authentication
Plugin URI: http://www.cubehouse.org
Description: Adds additional XML-RPC functions to Wordpress to allow external authentication with Jabber servers
Author: James Holding
Version: 1.0
Author URI: http://www.cubehouse.org
*/
add_filter('xmlrpc_methods', 'jabberauth_xmlrpc_methods');
function jabberauth_xmlrpc_methods($methods){
    $methods['xmpp.user_login'] = 'jabberauth_login';
    $methods['xmpp.user_check'] = 'jabberauth_check';
    return $methods;
}
function jabberauth_login($args){
    $username   = $args[0];
    $password   = $args[1];
    global $wp_xmlrpc_server;
    if (!$user = $wp_xmlrpc_server->login($username, $password)){
        return $wp_xmlrpc_server->error;
    }else{
        return $user->ID;
    }
}
function jabberauth_check($args){
    $userdata = get_user_by('login', $args[0]);
    if (!$userdata) return $wp_xmlrpc_server->error;
    return $userdata->ID;
}
?>