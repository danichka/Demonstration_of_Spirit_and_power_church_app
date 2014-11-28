# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Nav minimized status by parts.
  is_navbar_minimized = false
  is_links_minimized  = false

  # Status of navbar animation.
  is_navbar_transforming = false
  is_links_transforming  = false

  is_nav_minimized = () ->
    is_navbar_minimized && is_links_minimized

  is_nav_maximized = () ->
    !is_nav_minimized()

  is_nav_transforming_now = () ->
    is_navbar_transforming && is_links_transforming

  minimize_element = (element) ->
    element.addClass("minimized")
    element.removeAttr('style')

  maximize_element = (element) ->
    element.removeClass("minimized")
    element.removeAttr('style')

  $(document).on "scroll", ->
    SIZE_OF_BIG_NAV        = 90
    BIG_NAV_BOTTOM_PADDING = 15
    MIN_NAV_ACTUAL_HEIGHT  = 70
    MIN_NAV_PARTS          = 4
    MIN_NAV_PART_SIZE      = MIN_NAV_ACTUAL_HEIGHT / MIN_NAV_PARTS

    scrollTop     = $(window).scrollTop()
    navbar_links  = $("nav.navbar a")
    navbar        = $(".navbar")
    navbar_header = $(".navbar-header")

    if scrollTop > SIZE_OF_BIG_NAV
      # Minimizing.
      if is_nav_minimized() == false and is_nav_transforming_now() == false
        # Animation started.
        is_links_transforming  = true
        is_navbar_transforming = true

        # Make links smaller.
        navbar_links.animate({
          "padding-bottom": "#{MIN_NAV_PART_SIZE}px",
          "padding-top": "#{MIN_NAV_PART_SIZE}px"
        },
        complete: ->
          is_links_minimized = true
          is_links_transforming = false

          minimize_element(navbar_links)
        )

        # Make nav smaller too.
        navbar.animate({
          "min-height": "#{MIN_NAV_PART_SIZE}px"
        },
        complete: ->
          is_navbar_minimized = true
          is_navbar_transforming = false

          minimize_element(navbar)
        )

        # Nav header (css instead of animation to remove blinking).
        navbar_header.css("height": "#{MIN_NAV_PART_SIZE}px")
        minimize_element(navbar_header)
    else
      # Maximizing.
      if is_nav_maximized() == false && is_nav_transforming_now() == false
        # Animation started.
        is_links_transforming  = true
        is_navbar_transforming = true

        # Make links bigger.
        navbar_links.animate({
          "padding-bottom": "35px",
          "padding-top": "35px"
        },
        complete: ->
          is_links_minimized = false
          is_links_transforming = false

          maximize_element(navbar_links)
        )

        # Make navbar bigger.
        navbar.animate({
          "min-height": "#{SIZE_OF_BIG_NAV}px"
        },
        complete: ->
          is_navbar_minimized = false
          is_navbar_transforming = false

          maximize_element(navbar)
        )

        # Nav header (css instead of animation to remove blinking).
        navbar_header.css("height": SIZE_OF_BIG_NAV)
        maximize_element(navbar_header)
