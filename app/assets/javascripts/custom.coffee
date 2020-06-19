$(document).on 'turbolinks:load', ->
  $('#image_posts').infiniteScroll
    path: "nav.pagination a[rel=next]"
    append: ".image_post"
    history: false
    prefill: true
    status: '.page-load-status'
    hideNav: '.pagination'

  $('#users').infiniteScroll
    path: "nav.pagination a[rel=next]"
    append: ".user"
    history: false
    prefill: true
    status: '.page-load-status'
    hideNav: '.pagination'