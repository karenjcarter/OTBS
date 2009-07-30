ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase

  # Add more helper methods to be used by all tests here...

  # Assert the form tag.
  def assert_form_tag(action)
    assert_tag "form", :attributes => { :action => action,
                                        :method => "post" }
  end

  # Assert submit button with optional label.
  def assert_submit_button(button_label = nil)
    if button_label
      assert_tag "input", :attributes => { :type => "submit",
                                           :value => button_label}
    else
      assert_tag "input", :attributes => { :type => "submit" }
    end
  end
  
# Assert existence of form input field with attributes.
def assert_input_field(name, value, field_type, size, maxlength, options = {})
  attributes = { :name  => name,
                 :type => field_type,
                 :size  => size,
                 :maxlength => maxlength }
  # Surprisingly, attributes[:value] == nil is different from attributes
  # not having a :value key at all.
  attributes[:value] = value unless value.nil?
  tag = { :tag => "input", :attributes => attributes }
  # Merge tag hash with options, especially to handle :parent => error_div
  # option in error tests.
  tag.merge!(options)
  assert_tag tag
end

# Test the minimum or maximum length of an attribute.
def assert_length(boundary, object, attribute, length, options = {})
  valid_char = options[:valid_char] || "a"
  barely_invalid = barely_invalid_string(boundary, length, valid_char)
  # Test one over the boundary.
  object[attribute] = barely_invalid
  assert !object.valid?,
         "#{object[attribute]} (length #{object[attribute].length}) " +
         "should raise a length error"
  assert_equal correct_error_message(boundary, length),
               object.errors.on(attribute)

  # Test the boundary itself.
  barely_valid = valid_char * length
  object[attribute] = barely_valid
  assert object.valid?,
         "#{object[attribute]} (length #{object[attribute].length}) " +
         "should be on the boundary of validity"
end

# Create an attribute that is just barely invalid.
def barely_invalid_string(boundary, length, valid_char)
  if boundary == :max
    invalid_length = length + 1
  elsif boundary == :min
    invalid_length = length - 1
  else
    raise ArgumentError, "boundary must be :max or :min"
  end
  valid_char * invalid_length
end

# Return the correct error message for the length test.
def correct_error_message(boundary, length)
  error_messages = ActiveRecord::Errors.default_error_messages
  if boundary == :max
    sprintf(error_messages[:too_long], length)
  elsif boundary == :min
    sprintf(error_messages[:too_short], length)
  else
    raise ArgumentError, "boundary must be :max or :min"
  end
end


end


					