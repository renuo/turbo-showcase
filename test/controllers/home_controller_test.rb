require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "shows the homepage" do
    get root_path

    assert_response :success
    assert_select "h1", /welcome to Turbo Showcase/
    assert_select "a[href=?]", training_path
  end

  test "highlights the current page in the navigation" do
    get frames_path

    assert_select "a.nav-link.active[href=?]", frames_path
    assert_select "a.nav-link.active", count: 1
  end

  test "shows the frames page with its turbo frames" do
    get frames_path

    assert_response :success
    assert_select "turbo-frame#update-me a[href='/replace_update_me']"
    assert_select "turbo-frame#update-me a[data-turbo-frame='_top']"
    assert_select "turbo-frame#target-top[target='_top']"
    assert_select "turbo-frame#update-external a[data-turbo-frame='external-frame']"
    assert_select "turbo-frame#external-frame"
  end

  test "renders the replacement for the update-me frame" do
    get replace_update_me_path

    assert_response :success
    assert_select "turbo-frame#update-me", /I got replaced/
  end

  test "renders the page used to escape the frames" do
    get "/home/replace_whole_page"

    assert_response :success
    assert_select "p", /Also the Browser URL has been updated/
  end

  test "renders the replacement for the external frame" do
    get replace_external_frame_path

    assert_response :success
    assert_select "turbo-frame#external-frame a[data-turbo-frame='update-external']"
  end

  test "renders the replacement for the form frame" do
    get replace_form_frame_path

    assert_response :success
    assert_select "turbo-frame#update-external", /The form has disappeared/
  end

  test "shows the slow page with a lazily loaded frame" do
    get slow_path

    assert_response :success
    assert_select "turbo-frame#slow-frame[src='/slow_frame'] .fa-spinner"
  end

  test "renders the content of the slow frame" do
    get slow_frame_path

    assert_response :success
    assert_select "turbo-frame#slow-frame", /This took quite long/
  end

  test "paginates the elements by five" do
    get pagination_path

    assert_response :success
    assert_select "turbo-frame#pagination-frame[data-controller='url-updating-frame']"
    assert_select "#pagination-frame table td", count: 5
    assert_select "#pagination-frame table td", text: "0"
    assert_select "#pagination-frame table td", text: "4"
  end

  test "shows the requested page of elements" do
    get pagination_path(page: 8)

    assert_select "#pagination-frame table td", count: 1
    assert_select "#pagination-frame table td", text: "z"
  end

  test "shows the navigate away page" do
    get navigate_away_path

    assert_response :success
    assert_select "a", "go back"
  end

  test "shows the form with the default user" do
    get forms_path

    assert_response :success
    assert_select "turbo-frame#form-frame strong", "Dino Megazord"
    assert_select "turbo-frame#form-frame form[action='/form_submission']"
    assert_select "turbo-cable-stream-source", count: 1
    assert_select "ul#stream-list"
  end

  test "renders the submitted user and broadcasts it to the users list" do
    assert_turbo_stream_broadcasts "users", count: 1 do
      post form_submission_path, params: {user: {first_name: "Ada", last_name: "Lovelace"}}
    end

    assert_response :success
    assert_select "turbo-frame#form-frame strong", "Ada Lovelace"

    broadcast = capture_turbo_stream_broadcasts("users").last
    assert_equal "append", broadcast["action"]
    assert_equal "stream-list", broadcast["target"]
    assert_includes broadcast.to_html, "<li>Ada Lovelace</li>"
  end

  test "shows the inline editable fields" do
    get inline_fields_path

    assert_response :success
    assert_select "turbo-frame#frame-new_user-first_name", /Dino/
    assert_select "turbo-frame#frame-new_user-last_name", /Megazord/
  end

  test "renders the inline field with the submitted value" do
    post inline_form_submission_path, params: {user: {first_name: "Ada", last_name: "Megazord"}}

    assert_response :success
    assert_select "turbo-frame#frame-new_user-first_name .read-field", /Ada/
  end

  test "shows the streams page" do
    get streams_path

    assert_response :success
    assert_select "turbo-cable-stream-source", count: 1
    assert_select "turbo-frame#stream-title", /I have some content/
    assert_select "form[action='/refresh_stream_title'] button[type=submit]", "Click me"
  end

  test "broadcasts a random number to the stream title" do
    assert_turbo_stream_broadcasts "stream-id", count: 1 do
      post refresh_stream_title_path
    end

    assert_response :no_content

    broadcast = capture_turbo_stream_broadcasts("stream-id").last
    assert_equal "update", broadcast["action"]
    assert_equal "stream-title", broadcast["target"]
    assert_match(/Here is a random number: \d+/, broadcast.to_html)
  end

  test "shows the issues page" do
    get issues_path

    assert_response :success
    assert_select "form[action='/form_get_submission'][method='get']"
    assert_select "form[action='/form_get_submission'][method='post']"
  end

  test "renders the issues page after submitting with GET" do
    get form_get_submission_path

    assert_response :success
    assert_select "h5", "Form with method GET"
  end

  test "renders the issues page after submitting with POST" do
    post form_get_submission_path

    assert_response :success
    assert_select "h5", "Form with method POST"
  end
end
