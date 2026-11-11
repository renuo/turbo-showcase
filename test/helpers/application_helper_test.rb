require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "spinner is only visible while the element is disabled" do
    assert_dom_equal '<span class="show-when-disabled"><i class="fas fa-spinner fa-spin"></i></span>', spinner
    assert_predicate spinner, :html_safe?
  end
end
