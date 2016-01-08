# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# take in profile like profile-4 # also used in conversations coffee
scrollDownConversation = (profile) ->
  # conversation scroller
  scroller = $("##{profile} .scroll")
  scroller.scrollTop(scroller[0].scrollHeight - scroller[0].clientHeight)

$ ->
  # scroll when page loads
  console.log 'loaded conversations'
  profile = $('.tab-content .tab-pane.active').attr('id')
  scrollDownConversation profile
