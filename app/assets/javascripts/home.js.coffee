# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Nav minimized status by parts.
  is_navbar_minimized        = false
  is_navbar_header_minimized = false
  is_links_minimized         = false
  is_body_maximized          = false

  # Status of minimizing animation.
  is_navbar_minimized_animating        = false
  is_navbar_header_minimized_animating = false
  is_links_minimized_animating         = false
  is_body_maximized_animating          = false

  # Status of maximizing animation.
  is_navbar_maximized_animating        = false
  is_navbar_header_maximized_animating = false
  is_links_maximized_animating         = false
  is_body_minimized_animating          = false

  is_nav_minimized = () ->
    is_navbar_minimized && is_navbar_header_minimized && is_links_minimized && !is_body_maximized

  is_nav_maximized = () ->
    !is_nav_minimized()

  is_nav_minimizing_now = () ->
    is_navbar_minimized_animating && is_navbar_header_minimized_animating &&
    is_links_minimized_animating && is_body_maximized_animating

  is_nav_maximizing_now = () ->
    is_navbar_maximized_animating && is_navbar_header_maximized_animating &&
    is_links_maximized_animating && is_body_minimized_animating

  $(document).on "scroll", ->
    SIZE_OF_BIG_NAV = 90
    BIG_NAV_BOTTOM_PADDING = 15
    SIZE_OF_SMALL_NAV = 45
    MIN_NAV_ACTUAL_HEIGHT = 10

    scrollTop = $(window).scrollTop()

    if scrollTop > SIZE_OF_BIG_NAV
      # Minimizing.
      if is_nav_minimized() == false and is_nav_minimizing_now() == false
        # Animation started.
        is_navbar_minimized_animating        = true
        is_navbar_header_minimized_animating = true
        is_links_minimized_animating         = true
        is_body_maximized_animating          = true

        # Make links smaller.
        $("nav.navbar a").animate({
          "padding-bottom": "#{MIN_NAV_ACTUAL_HEIGHT}px",
          "padding-top": "#{MIN_NAV_ACTUAL_HEIGHT}px"
        },
        complete: ->
          is_links_minimized = true
          is_links_minimized_animating = false
        )

        # Make nav smaller too.
        $(".navbar").animate({
          "min-height": "#{MIN_NAV_ACTUAL_HEIGHT}px"
        },
        complete: ->
          is_navbar_minimized = true
          is_navbar_minimized_animating = false
        )

        # Nav header
        $(".navbar-header").animate({
          "height": "#{MIN_NAV_ACTUAL_HEIGHT}px"
        },
        complete: ->
          is_navbar_header_minimized = true
          is_navbar_header_minimized_animating = false
        )

        # Give more space to text when navbar become smaller.
        $("body").animate({
          "padding-top": "#{SIZE_OF_SMALL_NAV}px"
        },
        complete: ->
          is_body_maximized = false
          is_body_maximized_animating = false
        )
    else
      # Maximizing.
      if is_nav_maximized() == false && is_nav_maximizing_now() == false
        # Animation started.
        is_navbar_maximized_animating        = true
        is_navbar_header_maximized_animating = true
        is_links_maximized_animating         = true
        is_body_minimized_animating          = true

        # Make links bigger.
        $("nav.navbar a").animate({
          "padding-bottom": "35px",
          "padding-top": "35px"
        },
        complete: ->
          is_links_minimized = false
          is_links_maximized_animating = false
        )

        # Make navbar bigger.
        $(".navbar").animate({
          "min-height": "#{SIZE_OF_BIG_NAV}px"
        },
        complete: ->
          is_navbar_minimized = false
          is_navbar_maximized_animating = false
        )

        # Nav header
        $(".navbar-header").animate({
          "height": SIZE_OF_BIG_NAV
        },
        complete: ->
          is_navbar_header_minimized = false
          is_navbar_header_maximized_animating = false
        )

        # Give less space for text.
        $("body").animate({
          "padding-top": "#{SIZE_OF_BIG_NAV + BIG_NAV_BOTTOM_PADDING}px"
        },
        complete: ->
          is_body_maximized = true
          is_body_minimized_animating = false
        )
