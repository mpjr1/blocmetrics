class RegisteredApplicationsController < ApplicationController
  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end
  
  def create
    @registered_application = RegisteredApplication.new(registered_application_params)

    respond_to do |format|
      if @registered_application.save
        format.html { redirect_to @registered_application, notice: 'Registered application was successfully created.' }
        format.json { render :show, status: :created, location: @registered_application }
      else
        format.html { render :new }
        format.json { render json: @registered_application.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @registered_application = RegisteredApplication.find(params[:id])
    respond_to do |format|
      if @registered_application.update(registered_application_params)
        format.html { redirect_to @registered_application, notice: 'Registered application was successfully updated.' }
        format.json { render :show, status: :ok, location: @registered_application }
      else
        format.html { render :edit }
        format.json { render json: @registered_application.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    @registered_application.destroy
    respond_to do |format|
      format.html { redirect_to registered_applications_url, notice: 'Registered application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    
    def registered_application_params
      params.require(:registered_application).permit(:name, :url, :user_id)
    end
  
end
