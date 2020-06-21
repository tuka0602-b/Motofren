$(document).on 'turbolinks:load', ->
  $('[data-toggle="popover"]').popover
    container: 'body'
    trigger: 'focus'

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

  $('#recruitments').infiniteScroll
    path: "nav.pagination a[rel=next]"
    append: ".recruitment"
    history: false
    prefill: true
    status: '.page-load-status'
    hideNav: '.pagination'

  $('#notifications').infiniteScroll
    path: "nav.pagination a[rel=next]"
    append: ".notification"
    history: false
    prefill: true
    status: '.page-load-status'
    hideNav: '.pagination'