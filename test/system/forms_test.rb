require "application_system_test_case"

class FormsTest < ApplicationSystemTestCase
  test "submits the form inside the frame and streams the user to the list" do
    visit forms_path
    assert_text "Dino Megazord"
    # wait for the stream subscription, otherwise the broadcast could be missed
    assert_selector "turbo-cable-stream-source[connected]", visible: :all

    fill_in "First name", with: "Ada"
    fill_in "Last name", with: "Lovelace"
    click_on "Submit"

    within("turbo-frame#form-frame") { assert_selector "strong", text: "Ada Lovelace" }
    within("#stream-list") { assert_selector "li", text: "Ada Lovelace" }
    assert_current_path forms_path
  end

  test "edits an inline field" do
    visit inline_fields_path
    within("turbo-frame#frame-new_user-first_name") do
      find(".read-field").click
      fill_in "user[first_name]", with: "Ada"
      find("button[type=submit]").click

      assert_selector ".read-field", text: "Ada"
      assert_no_field "user[first_name]"
    end
    assert_current_path inline_fields_path
  end

  test "cancels editing an inline field" do
    visit inline_fields_path
    within("turbo-frame#frame-new_user-last_name") do
      find(".read-field").click
      assert_field "user[last_name]", with: "Megazord"

      find("button[data-action='click->editable-field#cancel']").click

      assert_selector ".read-field", text: "Megazord"
      assert_no_field "user[last_name]"
    end
  end
end
