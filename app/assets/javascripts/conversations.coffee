# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# takes in profile_id like 4
scrollDownConversation = (profile_id) ->
  # conversation scroller
  scroller = $("#profile-#{profile_id} .scroll")
  scroller.scrollTop(scroller[0].scrollHeight - scroller[0].clientHeight)

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
      return if scroller.children().length == data.length
      scroller.html('')
      # console.log data
      $.each(data, (index, convo) ->
        console.log convo
        scroller.append HandlebarsTemplates['convo'](convo)
        scrollDownConversation profile_id
      )

# interval function for polling for messages
# grabs the active tab profile_id
pollMessages = () ->
  profile = $('.tab-content .tab-pane.active').attr('id')
  # get id from profile
  profile_id = profile.split('-')[1]
  refreshMessages profile_id

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
    refreshMessages profile_id
    return
  )

  # load convos when page loads
  console.log 'loaded conversations'
  pollMessages()
  refresh = setInterval(pollMessages, 3000) # make more than the timeout period
