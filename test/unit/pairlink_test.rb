require 'test_helper'

class PairlinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "the truth" do
    pair = Pairlink.new(:url => "ochinpo.rar" )
    assert pair.set_to_states == 0
  end
end
