require "application_system_test_case"

class StreamsTest < ApplicationSystemTestCase
  # turbo-rails includes ActionCable::TestHelper in every test case once Action Cable
  # is loaded. Its before_setup swaps the configured adapter for an in-memory one, so
  # a broken Solid Cable setup (e.g. a missing migration) would go unnoticed. Put the
  # real adapter back for this test only, the other system tests keep the fast one.
  def before_setup
    super
    ActionCable.server.instance_variable_set(:@pubsub, @old_pubsub_adapter) if @old_pubsub_adapter
  end

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
