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

  $(document).on "scroll", ->
    SIZE_OF_BIG_NAV = 90
    BIG_NAV_BOTTOM_PADDING = 15
    SIZE_OF_SMALL_NAV = 45
    MIN_NAV_ACTUAL_HEIGHT = 10

    scrollTop = $(window).scrollTop()

    if scrollTop > SIZE_OF_BIG_NAV
      # Minimizing.
      if is_nav_minimized() == false and is_nav_transforming_now() == false
        # Animation started.
        is_links_transforming  = true
        is_navbar_transforming = true

        # Make links smaller.
        $("nav.navbar a").animate({
          "padding-bottom": "#{MIN_NAV_ACTUAL_HEIGHT}px",
          "padding-top": "#{MIN_NAV_ACTUAL_HEIGHT}px"
        },
        complete: ->
          is_links_minimized = true
          is_links_transforming = false

          $("nav.navbar a").addClass("minimized")
          $("nav.navbar a").removeAttr('style')
        )

        # Make nav smaller too.
        $(".navbar").animate({
          "min-height": "#{MIN_NAV_ACTUAL_HEIGHT}px"
        },
        complete: ->
          is_navbar_minimized = true
          is_navbar_transforming = false

          $("nav.navbar").addClass("minimized")
          $("nav.navbar").removeAttr('style')
        )

        # Nav header (css instead of animation to remove blinking).
        $(".navbar-header").css("height": "#{MIN_NAV_ACTUAL_HEIGHT}px")
        $(".navbar-header").addClass("minimized")
        $(".navbar-header").removeAttr('style')
    else
      # Maximizing.
      if is_nav_maximized() == false && is_nav_transforming_now() == false
        # Animation started.
        is_links_transforming  = true
        is_navbar_transforming = true

        # Make links bigger.
        $("nav.navbar a").animate({
          "padding-bottom": "35px",
          "padding-top": "35px"
        },
        complete: ->
          is_links_minimized = false
          is_links_transforming = false

          $("nav.navbar a").removeClass("minimized")
          $("nav.navbar a").removeAttr('style')
        )

        # Make navbar bigger.
        $(".navbar").animate({
          "min-height": "#{SIZE_OF_BIG_NAV}px"
        },
        complete: ->
          is_navbar_minimized = false
          is_navbar_transforming = false

          $(".navbar").removeClass("minimized")
          $(".navbar").removeAttr('style')
        )

        # Nav header (css instead of animation to remove blinking).
        $(".navbar-header").css("height": SIZE_OF_BIG_NAV)
        $(".navbar-header").removeClass("minimized")
        $(".navbar-header").removeAttr('style')
