class EditableFieldComponent < ViewComponent::Base
  include Turbo::FramesHelper
  include ActiveModel::AttributeAssignment

  attr_accessor :model, :attribute

  def initialize(attributes = {})
    super()
    assign_attributes(attributes) if attributes
  end

  def display_value
    @model.public_send(@attribute).presence || '<div class="text-muted">-</div>'.html_safe
  end

  def frame_tag_id
    "frame-#{dom_id(@model)}-#{@attribute}"
  end

  def can_edit?
    true
    # your logic. we use cancancan with `helpers.can? :update, @model`
  end

  def spinner
    '<i class="fas fa-spinner fa-spin"></i>'
  end
end
