require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "assigns the names" do
    user = User.new(first_name: "Dino", last_name: "Megazord")

    assert_equal "Dino", user.first_name
    assert_equal "Megazord", user.last_name
    assert_not_predicate user, :persisted?
  end
end
