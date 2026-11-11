require "application_system_test_case"

class StreamsTest < ApplicationSystemTestCase
  test "updates the title through a turbo stream" do
    visit streams_path
    within("turbo-frame#stream-title") { assert_text "I have some content" }
    # wait for the stream subscription, otherwise the broadcast could be missed
    assert_selector "turbo-cable-stream-source[connected]", visible: :all

    click_on "Click me"

    within("turbo-frame#stream-title") { assert_text(/Here is a random number: \d+/) }
    assert_current_path streams_path
  end
end
