 class API::EventsController < ApplicationController
   skip_before_action :verify_authenticity_token 
   before_filter :set_access_control_headers

   def set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Content-Type'
   end

 
   def index
    if request.method == "OPTIONS"
     render :json => '', :content_type => 'application/json'
     return
    end
   end
   
   def create
    registered_application = RegisteredApplication.where(url: request.env['HTTP_ORIGIN']).try(:first)
    if registered_application.nil?
      render json: "Unregistered application", status: :unprocessable_entity
    else
      @event = registered_application.events.new(event_params)
      if @event.save
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

   private
   
   def event_params
     params.permit(:name)
   end
   
 end