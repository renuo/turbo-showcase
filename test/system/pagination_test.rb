require "application_system_test_case"

class PaginationTest < ApplicationSystemTestCase
  test "paginates inside the frame and keeps the page in the URL" do
    visit pagination_path
    within("turbo-frame#pagination-frame") { click_on "2" }

    within("turbo-frame#pagination-frame table") { assert_text "5" }
    assert_current_path pagination_path(page: 2)

    click_on "navigate away"
    assert_text "the pagination of the table will be persisted"

    click_on "go back"

    assert_current_path pagination_path(page: 2)
    within("turbo-frame#pagination-frame table") do
      assert_text "5"
      assert_no_text "0"
    end
  end
end
