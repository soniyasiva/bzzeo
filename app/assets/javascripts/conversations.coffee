# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# take in profile like profile-4 # also used in conversations coffee
scrollDownConversation = (profile) ->
  # conversation scroller
  scroller = $("##{profile} .scroll")
  scroller.scrollTop(scroller[0].scrollHeight - scroller[0].clientHeight)

$ ->
  # handles convo profile click
  $('a.convo-profile').on('click', (e) ->
    console.log 'convo-profile fired'
    e.preventDefault()
    # show tab
    $(this).tab 'show'
    # profile-id
    profile = $(this).attr('aria-controls')
    profile_id = profile.split('-')[1]
    # get convos
    $.ajax
      url: "/conversations/with?profile_id=#{profile_id}"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        console.log 'success'
        console.log data

    scrollDownConversation profile
    return
  )

  # scroll when page loads
  console.log 'loaded conversations'
  profile = $('.tab-content .tab-pane.active').attr('id')
  scrollDownConversation profile
