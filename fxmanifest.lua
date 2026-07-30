fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Lukintore'

name 'svrk-natguard'
description 'Entity native safety wrappers — loaded by other resources via @svrk-natguard/natguard.lua'
version '1.0.0'

-- natguard.lua is loaded by other resources as a shared file, not by this resource
-- This resource just needs to exist so FxServer can serve the file
file 'natguard.lua'
