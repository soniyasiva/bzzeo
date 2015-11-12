# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require turbolinks
#= require_tree .



# Rails creates this event, when the link_to(remote: true) successfully executes
$(document).on 'ajax:success', 'a.like', (status,data,xhr)->
  # update counter
  $(".likes-count[data-id=#{data.id}]").text data.count

  # toggle links text
  $("a.like[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Like")
    else
      $(this).text("Unlike")

# Rails creates this event, when the link_to(remote: true) successfully executes
$(document).on 'ajax:success', 'a.friend', (status,data,xhr)->
  console.log 'friend'
  # toggle links text
  $("a.friend[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Follow")
    else
      $(this).text("Unfollow")

# Rails creates this event, when the link_to(remote: true) successfully executes
$(document).on 'ajax:success', 'a.partner', (status,data,xhr)->
  console.log 'partner'
  # toggle links text
  $("a.partner[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Partner")
    else
      $(this).text("Unpartner")

$(document).on 'ajax:success', '.new_comment', (status,data,xhr)->
  console.log "comment"
  console.log data

# document ready
$ ->
  # toggle comment box for post
  $(".new-comment-toggle").on('click', ->
    console.log 'comment toggle'
    post_id = $(this).data('new-comment-id')
    $(".new-comment[data-new-comment-id=#{post_id}]").toggle()
    false # prevent default
  )
