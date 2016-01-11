# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# breaklines in .hbs files helper
Handlebars.registerHelper 'breaklines', (text) ->
  text = Handlebars.Utils.escapeExpression(text)
  text = text.replace(/(\r\n|\n|\r)/gm, '<br>')
  new (Handlebars.SafeString)(text)

# last message helper
Handlebars.registerHelper 'truncate', (text) ->
  text = text.substring(0,11)
  new (Handlebars.SafeString)(text)

# time ago helper
Handlebars.registerHelper 'timeAgo', (text) ->
  text = text.replace('about ', '')
  new (Handlebars.SafeString)(text)

# takes in profile_id like 4
scrollDownConversation = (profile_id) ->
  console.log 'scrollDownConversation'
  # conversation scroller
  scroller = $("#profile-#{profile_id} .scroll")
  $("#profile-#{profile_id} .scroll .convo").last()[0].scrollIntoView()
  return

# takes in profile_id like 4
refreshMessages = (profile_id) ->
  # get convos
  $.ajax
    url: "/conversations/with?profile_id=#{profile_id}"
    dataType: "json"
    timeout: 2000 # make less than the refresh period
    success: (data, textStatus, jqXHR) ->
      console.log 'success'
      scroller = $("#profile-#{profile_id} .scroll")
      # do nothing if no new messages
      return if scroller.children().length == data.length
      # empty space
      scroller.html('')
      # console.log data
      $.each(data, (index, convo) ->
        scroller.append HandlebarsTemplates['convo'](convo)
      )
      scrollDownConversation profile_id
      # last message
      last_message = data[data.length - 1]
      $('.nav-list li.active .last-message').html(HandlebarsTemplates['last-convo'](last_message))
      return
  return

updateConvoName = ->
  profile = $('.conversation-profiles li.active .profile-name').html()
  $('.conversation-convos .profile-name').html(profile)
  return

# interval function for polling for messages
# grabs the active tab profile_id
pollMessages = () ->
  profile = $('.tab-content .tab-pane.active').attr('id')
  # get id from profile
  profile_id = profile.split('-')[1]
  return if not profile_id?
  refreshMessages profile_id
  return

$ ->
  # handles convo profile click
  $('a.convo-profile').on('click', (e) ->
    console.log 'convo-profile fired'
    e.preventDefault()
    # show tab
    $(this).tab 'show'
    # profile-id
    profile = $(this).attr('aria-controls')
    # get id from profile
    profile_id = profile.split('-')[1]
    updateConvoName()
    refreshMessages profile_id
    # toggle mobile profiles menu
    $('.conversation-profiles').toggleClass('hidden-xs')
    $('.conversation-convos').toggleClass('hidden-xs')
    return
  )

  # menu selector
  $('.btn-profile-select').on('click', (e) ->
    console.log 'btn-profile-select'
    # toggle mobile profiles menu
    $('.conversation-profiles').toggleClass('hidden-xs')
    $('.conversation-convos').toggleClass('hidden-xs')
    e.preventDefault()
    return
  )

  # load convos when page loads
  console.log 'loaded conversations'
  # pollMessages()
  updateConvoName()
  refresh = setInterval(pollMessages, 3000) # make more than the timeout period
