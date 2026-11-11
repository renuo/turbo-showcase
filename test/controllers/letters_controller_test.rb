require "test_helper"

class LettersControllerTest < ActionDispatch::IntegrationTest
  test "shows the letter" do
    get "/letters/k"

    assert_response :success
    assert_select "div", "k"
    assert_select "a", "Nice letter. Go back"
  end

  test "shows the letter slowly" do
    get "/letters/k/slow"

    assert_response :success
    assert_select "div", "k"
  end
end
