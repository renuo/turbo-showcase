require "test_helper"

class TrainingControllerTest < ActionDispatch::IntegrationTest
  test "shows the training boilerplate" do
    get training_path

    assert_response :success
    assert_select "code", /turbo-frame id="update-me"/
  end

  test "shows the training instructions" do
    get training_instructions_path

    assert_response :success
    assert_select ".card-header h5", text: /\A\d\. /, count: 6
    assert_select "turbo-frame#replace_me_3"
    assert_select "a[href='/letters/a']"
    assert_select "a[href='/letters/z']"
  end
end
