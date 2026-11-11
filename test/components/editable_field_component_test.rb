require "test_helper"

class EditableFieldComponentTest < ViewComponent::TestCase
  test "renders the value and a hidden form to edit it" do
    render_inline(EditableFieldComponent.new(model: User.new(first_name: "Dino"), attribute: :first_name))

    assert_selector "turbo-frame#frame-new_user-first_name"
    assert_selector "[data-controller='editable-field'] .read-field", text: "Dino"
    assert_selector "form[action='/inline_form_submission'] input[name='user[first_name]'][value='Dino']", visible: :hidden
  end

  test "renders a placeholder when the value is blank" do
    render_inline(EditableFieldComponent.new(model: User.new, attribute: :last_name))

    assert_selector "turbo-frame#frame-new_user-last_name .read-field .text-muted", text: "-"
  end
end
