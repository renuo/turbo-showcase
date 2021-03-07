class HomeController < ApplicationController
  def show
    @elements = Kaminari.paginate_array((0...36).map { |i| i.to_s 36 }).page(params[:page]).per(5)
  end

  # we return some HTML that contains a turbo-frame with id 'update-me'
  def replace_update_me
  end

  def replace_whole_page
  end

  # we return some HTML that contains a turbo-frame with id 'external-frame'
  def replace_external_frame
  end

  # we return some HTML that contains a turbo-frame with id 'form-frame'
  def replace_form_frame
  end

  def slow_frame
    sleep 5
  end

  def refresh_stream_title
    Turbo::StreamsChannel.broadcast_action_to("stream-id", action: :update,
                                                           target: "stream-title",
                                                           content: "Here is a random number: #{rand(1..100)}")
  end
end
