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



# on post like success
$(document).on 'ajax:success', 'a.like', (status,data,xhr)->
  # update counter
  $(".likes-count span[data-id=#{data.id}]").text data.count

  # toggle links text
  $("a.like[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Like")
    else
      $(this).text("Unlike")

# on post upvote success
$(document).on 'ajax:success', 'a.upvote', (status,data,xhr)->
  console.log 'upvote'
  console.log data
  # update counter
  $(".upvotes-count span[data-id=#{data.id}]").text data.count

  # toggle links text
  $("a.upvote[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Upvote")
    else
      $(this).text("Unupvote")

# on profile friend success
$(document).on 'ajax:success', 'a.friend', (status,data,xhr)->
  console.log 'friend'
  # toggle links text
  $("a.friend[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).html($(this).html().replace('Unf', 'F'))
    else
      $(this).html($(this).html().replace('F', 'Unf'))

# on profile partner button success
$(document).on 'ajax:success', 'a.partner', (status,data,xhr)->
  console.log 'partner'
  # toggle links text
  $("a.partner[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).html($(this).html().replace('Unp', 'P'))
    else
      $(this).html($(this).html().replace('P', 'Unp'))

# on new comment for post success
$(document).on 'ajax:success', '.new_comment', (status,data,xhr)->
  console.log "comment"
  comment = data.comment
  # insert comment with template into posts
  $(".comments[data-id=#{data.id}] > .col-xs-12").append("
    <div class=\"row comment\">
      <div class=\"col-xs-12\">
        <div class=\"row profile\">
          <div class=\"col-xs-12\">
            #{data.profile.name}
          </div>
        </div>
        <div class=\"row description\">
          <div class=\"col-xs-12\">
            #{data.comment.description}
          </div>
        </div>
      </div>
    </div>")
  # empty the box
  $('.new-comment textarea').val('')

# document ready
$ ->
  # toggle comment box for post
  $(".new-comment-toggle").on('click', ->
    console.log 'comment toggle'
    post_id = $(this).data('new-comment-id')
    $(".new-comment[data-new-comment-id=#{post_id}]").toggle()
    false # prevent default
  )
  # toggle comment box for post
  $(".post .video a").on('click', ->
    console.log 'post video thumb clicked'
    postId = $(this).data('id')
    $(".post iframe[data-id=#{postId}]").show()
    $(this).hide()
    # $(".post .thumb-wrap[data-id=#{postId}]").hide()
    false # prevent default
  )
  # reveals profile map on location click
  $('.location-button').on('click', ->
    console.log 'location button clicked'
    # show map
    $('.profile-map').toggleClass('hidden')
    false # prevent default
  )
