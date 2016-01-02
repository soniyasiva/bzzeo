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
#= require handlebars
#= require twitter/typeahead
#= require_tree .



# on post like success
$(document).on 'ajax:success', 'a.like', (status,data,xhr)->
  console.log 'like'
  # update counter
  $(".likes-count span[data-id=#{data.id}]").text data.count

  # toggle links text
  $("a.like[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Like")
    else
      $(this).text("Unlike")

# on post pin success
$(document).on 'ajax:success', 'a.pin', (status,data,xhr)->
  console.log 'pin'
  # update counter
  $("span.pinned[data-id=#{data.id}]").toggleClass('hidden')

  # toggle links text
  $("a.pin[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).text("Pin")
    else
      $(this).text("Unpin")

updateVotes = (data) ->
  console.log data
  # toggle links text
  $(".votes-count span[data-id=#{data.id}]").each ->
    $(this).text(data.votes)
  # ipvote arrow
  $("a.upvote[data-id=#{data.id}]").each ->
    if data.dislike is off
      $(this).addClass('active')
    else
      $(this).removeClass('active')
  # downvote arrow
  $("a.downvote[data-id=#{data.id}]").each ->
    if data.dislike is on
      $(this).addClass('active')
    else
      $(this).removeClass('active')

# on post upvote success
$(document).on 'ajax:success', 'a.upvote', (status,data,xhr)->
  console.log 'upvote'
  # update counter
  $(".upvotes-count span[data-id=#{data.id}]").text data.count
  updateVotes data

# on post downvote success
$(document).on 'ajax:success', 'a.downvote', (status,data,xhr)->
  console.log 'downvote'
  # update counter
  $(".downvotes-count span[data-id=#{data.id}]").text data.count
  updateVotes data

# on profile friend success
$(document).on 'ajax:success', 'a.friend', (status,data,xhr)->
  console.log 'friend'
  # toggle links text
  $("a.friend[data-id=#{data.id}]").each ->
    if $(this).text().indexOf("Un") > -1
      $(this).html($(this).html().replace('Unf', 'F'))
    else
      $(this).html($(this).html().replace('F', 'Unf'))
      # redirect to messages
      window.location.replace("/conversations/new?profile_id=#{data.id}")

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
            <a href=\"/profiles/#{data.profile.id}\">
              #{data.profile.name}
            </a>
          </div>
        </div>
        <div class=\"row comment-description\">
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
  $(".post-category-selector .category-option").on('click', ->
    console.log 'category selected'
    # console.log
    $('.post-category-selector li').removeClass('active')
    $(this).closest('li').addClass('active')
    $('.post-category-selector #_category_id').val($(this).data('id'))

  )
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
  # reveals location search in menu
  $('.search-filter-btn').on('click', ->
    console.log 'filter button clicked'
    $('.menu-search .address').toggleClass('hidden');
    false
  )

  # twitter typeahead
  numbers = new Bloodhound(
    {
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name')
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch: '/profiles.json' # profiles by default
      # use normal search function
      remote: {
        url: '/feeds/search.json?query=%QUERY'
        wildcard: '%QUERY'
      }
    }
  )
  # initialize the bloodhound suggestion engine
  numbers.initialize()
  # instantiate the typeahead UI
  $('.example-numbers .typeahead').typeahead {
      minLength: 2
    },
    {
      displayKey: 'name'
      limit: 6
      source: numbers.ttAdapter()
      templates:
        suggestion: Handlebars.compile('<div><p>{{name}}</p><p>{{description}}</p></div>')
    }
