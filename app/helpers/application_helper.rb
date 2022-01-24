module ApplicationHelper
  def spinner
    raw_spinner.html_safe
  end

  def raw_spinner
    '<span class="show-when-disabled"><i class="fas fa-spinner fa-spin"></i></span>'
  end
end
