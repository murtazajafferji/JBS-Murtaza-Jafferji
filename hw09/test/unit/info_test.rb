require 'test_helper'

class InfoTest < ActiveSupport::TestCase
  fixtures :infos
  
  test "invalid with empty attributes" do
    info = Info.new
    assert !info.valid?
    assert info.errors.invalid?(:name)
  end
end
