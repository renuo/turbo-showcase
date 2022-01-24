class HomeController < ApplicationController
  def show
  end

  def frames
  end

  def slow
  end

  def pagination
    @elements = Kaminari.paginate_array((0...36).map { |i| i.to_s 36 }).page(params[:page]).per(5)
  end

  def forms
    # https://www.youtube.com/watch?v=TBHKeRWKqN8
    @user = User.new(first_name: "Dino", last_name: "Megazord")
  end

  # we return some HTML that contains a turbo-frame with id 'update-me'
  def replace_update_me
  end

  def navigate_away
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

  def inline_fields
    @user = User.new(first_name: "Dino", last_name: "Megazord")
  end

  def refresh_stream_title
    Turbo::StreamsChannel.broadcast_action_to("stream-id", action: :update,
                                                           target: "stream-title",
                                                           content: "Here is a random number: #{rand(1..100)}")
  end

  # here we save some content and then redirect back to the root page
  def form_submission
    # save stuff...
    sleep 0.5
    @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
    render "forms"
  end

  def issues
    @user = User.new
  end

  def form_get_submission
    # save stuff...
    sleep 2
    @user = User.new
    render "issues"
  end

  def inline_form_submission
    # save stuff...
    sleep 1
    @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
    render "inline_fields"
  end
end
