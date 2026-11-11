require "application_system_test_case"

class FramesTest < ApplicationSystemTestCase
  test "replaces only the content of the frame and restores it" do
    visit frames_path
    click_on "Replace only the content of this turbo-frame"

    within("turbo-frame#update-me") { assert_text "I got replaced" }
    assert_current_path frames_path
    assert_text "External frame navigation"

    within("turbo-frame#update-me") { click_on "Restore original content" }

    within("turbo-frame#update-me") { assert_link "Replace only the content of this turbo-frame" }
  end

  test "escapes the frame with data-turbo-frame _top" do
    visit frames_path
    click_on "Reload the whole page with `data-turbo-frame: '_top'`"

    assert_text "Also the Browser URL has been updated"
    assert_current_path "/home/replace_whole_page"
  end

  test "escapes the frame with target _top" do
    visit frames_path
    click_on "Reload the whole page with `target: '_top'`"

    assert_text "Also the Browser URL has been updated"
    assert_current_path "/home/replace_whole_page"
  end

  test "escapes the frame when the wrapping frame targets _top" do
    visit frames_path
    click_on "Reload the whole page when the nearest wrapping turbo-frame has `target: '_top'`"

    assert_text "Also the Browser URL has been updated"
    assert_current_path "/home/replace_whole_page"
  end

  test "replaces the content of other frames" do
    visit frames_path
    click_on "Reload the content of `external-frame`"

    within("turbo-frame#external-frame") { assert_text "I got replaced" }
    within("turbo-frame#update-external") { assert_link "Reload the content of `external-frame`" }

    click_on "Replace the content of the form-frame"

    within("turbo-frame#update-external") { assert_text "The form has disappeared" }
    assert_current_path frames_path
  end

  test "loads a frame lazily" do
    visit slow_path

    within("turbo-frame#slow-frame") { assert_text "This took quite long" }
  end
end
