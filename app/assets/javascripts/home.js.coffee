# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Nav minimized status by parts.
  is_navbar_minimized    = false
  is_links_minimized     = false
  is_brand_img_minimized = false

  # Status of navbar animation.
  is_navbar_transforming    = false
  is_links_transforming     = false
  is_brand_img_transforming = false

  sass_vars = gon.sass_vars
  origin_brand_img_width = null                                                                     # Just init global variable with anything.

  MIN_NAV_BRAND_IMG_WIDTH = SassConverterHelpers.value_to_int(sass_vars['min_nav_brand_img_width'])
  SIZE_OF_BIG_NAV         = SassConverterHelpers.value_to_int(sass_vars['big_nav_height'])
  BIG_NAV_BOTTOM_PADDING  = SassConverterHelpers.value_to_int(sass_vars['big_nav_bottom_padding'])
  BIG_NAV_LINKS_PADDING   = 35
  MIN_NAV_ACTUAL_HEIGHT   = SassConverterHelpers.value_to_int(sass_vars['min_nav_height'])
  NAV_PARTS               = sass_vars['nav_parts']
  MIN_NAV_PART_SIZE       = MIN_NAV_ACTUAL_HEIGHT / NAV_PARTS

  is_nav_minimized = () ->
    is_navbar_minimized && is_links_minimized && is_brand_img_minimized

  is_nav_maximized = () ->
    !is_nav_minimized()

  is_nav_transforming_now = () ->
    is_navbar_transforming && is_links_transforming && is_brand_img_transforming

  minimize_element = (element) ->
    element.addClass("minimized")
    element.removeAttr('style')

  maximize_element = (element) ->
    element.removeClass("minimized")
    element.removeAttr('style')

  navbar_animation_started = () ->
    is_links_transforming     = true
    is_navbar_transforming    = true
    is_brand_img_transforming = true

  $(document).on "scroll", ->
    scrollTop     = $(window).scrollTop()
    navbar_links  = $("nav.navbar a")
    navbar        = $(".navbar")
    navbar_header = $(".navbar-header")
    brand_img     = $("img#brand-image")

    if scrollTop > SIZE_OF_BIG_NAV
      # Minimizing.
      if is_nav_minimized() == false and is_nav_transforming_now() == false
        navbar_animation_started()

        # Evaluating real width of brand image, and put value to global var.
        origin_brand_img_width = brand_img.width()

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

        # Make brand img smaller.
        brand_img.animate({
          "width": "#{MIN_NAV_BRAND_IMG_WIDTH}px"
        },
        complete: ->
          is_brand_img_minimized = true
          is_brand_img_transforming = false

          minimize_element(brand_img)
        )

        # Nav header (css instead of animation to remove blinking).
        navbar_header.css("height": "#{MIN_NAV_PART_SIZE}px")
        minimize_element(navbar_header)
    else
      # Maximizing.
      if is_nav_maximized() == false && is_nav_transforming_now() == false
        navbar_animation_started()

        # Make links bigger.
        navbar_links.animate({
          "padding-bottom": "#{BIG_NAV_LINKS_PADDING}px",
          "padding-top": "#{BIG_NAV_LINKS_PADDING}px"
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

        # Make brand img smaller.
        brand_img.animate({
          "width": "#{origin_brand_img_width}px"
        },
        complete: ->
          is_brand_img_minimized = false
          is_brand_img_transforming = false

          maximize_element(brand_img)
        )

        # Nav header (css instead of animation to remove blinking).
        navbar_header.css("height": SIZE_OF_BIG_NAV)
        maximize_element(navbar_header)
