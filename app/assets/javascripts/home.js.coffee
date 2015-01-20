jQuery ->
  $(window).load ->
    animate_hello_text()
    animate_lookup_blocks() if isPartiallyScrolledIntoViewOrHigherThenWindow("#lookup-section")

  $(document).on "scroll", ->
    animate_lookup_blocks() if isPartiallyScrolledIntoViewOrHigherThenWindow("#lookup-section")

  animate_hello_text = () ->
    $("#hello-text").addClass('animated fadeInUp')

  animate_lookup_blocks = () ->
    ids = ["#photos-lookup-block", "#sermons-lookup-block", "#videos-lookup-block", "#map-lookup-block"]

    for id, index in ids
      do (id, index) ->
        timeout_value = index * 150
        setTimeout (-> animate_lookup_block(id)), timeout_value

  animate_lookup_block = (id) ->
    $(id).removeClass("hidden")
    $(id).addClass('animated fadeIn')

  # Detecting if element is partially on the screen.
  #
  # elem - selector of element, for example "#lookup-section".
  # offset - how earlier element should be detected (it's size of elem - offset).
  isPartiallyScrolledIntoViewOrHigherThenWindow = (elem, offset = 150) ->
    docViewTop = $(window).scrollTop()
    docViewBottom = docViewTop + $(window).height()
    elemTop = $(elem).offset().top
    elemBottom = elemTop + $(elem).height() - offset

    return ((elemBottom <= docViewBottom) and (elemTop >= docViewTop)) or (docViewBottom > elemBottom)