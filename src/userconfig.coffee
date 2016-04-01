# Description:
#   Set user config vars
#
# Dependencies:
#   None
#
# Configuration
#   None
#
# Commands:
#   hubot set my <key> to <value> - set config variable
#   hubot unset my <key> - unset config variable
#   hubot get my config - get configs
#
# Author:
#   brentmaxwell

getUserConfig = (userid) ->
  return robot.brain.data.users[userid].config ?={};
  
setUserConfig = (userId,key,value) ->
  userConfig = getUserConfig(userId)
  userConfig[key] = value
  robot.brain.data.users[userId].config = userConfig

unsetUserConfig = (userid,key) ->
  delete robot.brain.data.users[userid].config[key]

module.exports = (robot) ->

  robot.respond /set my (.+?) to (.+?)$/i, id:'userconfig:set', (res) ->
    setUserConfig(res.message.user.id,res.match[1],res.match[2])
    res.send "I have set your #{res.match[1]} to #{res.match[2]}."

  robot.respond /unset my (.+?)$/i, id:'userconfig:unset', (res) ->
    unsetUserConfig(res.message.user.id,res.match[1])
    res.send "I have unset #{res.match[1]}."
  
  robot.respond /get my config$/, id:'userconfig:getall', (res) ->
    res.send JSON.stringify(getUserConfig(res.message.user.id))
    
  
  