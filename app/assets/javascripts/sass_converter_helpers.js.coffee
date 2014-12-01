class SassConverterHelpers
  # Convert value to int.
  #
  # Example:
  # value_to_int("767px")
  # => 767
  @value_to_int = (value) ->
    extracted_int_in_str = value.match(/\d+/g)
    parseInt(extracted_int_in_str)

# Export SassConverterHelpers class
window.SassConverterHelpers ||= SassConverterHelpers

