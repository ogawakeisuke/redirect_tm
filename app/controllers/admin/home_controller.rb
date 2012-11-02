class Admin::HomeController < ApplicationController
 before_filter :auth, :only => "index"
 # GET /Pairlinks
  # GET /Pairlinks.json
  def index
    @pairlinks = Pairlink.find(:all,:order=>"id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pairlinks }
    end
  end

  # GET /Pairlinks/1
  # GET /Pairlinks/1.json
  def show
    @pairlink = Pairlink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pairlink }
    end
  end

  # GET /Pairlinks/new
  # GET /Pairlinks/new.json
  def new
    @pairlink = Pairlink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pairlink }
    end
  end

  # GET /Pairlinks/1/edit
  def edit
    @pairlink = Pairlink.find(params[:id])
    logger.debug "mendoi------"
    logger.debug @pairlink.to_yaml
  end

  # POST /Pairlinks
  # POST /Pairlinks.json
  def create
    @pairlink = Pairlink.new(params[:pairlink])

    respond_to do |format|
      if @pairlink.save
        format.html { redirect_to :action=>'index', notice: 'Pairlink was successfully created.' }
        format.json { render json: @pairlink, status: :created, location: @pairlink }
      else
        format.html { render action: "new" }
        format.json { render json: @pairlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Pairlinks/1
  # PUT /Pairlinks/1.json
  def update
    @pairlink = Pairlink.find(params[:id])

    respond_to do |format|
      if @pairlink.update_attributes(params[:pairlink])
        format.html { redirect_to :action=>'index', notice: 'Pairlink was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pairlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Pairlinks/1
  # DELETE /Pairlinks/1.json
  def destroy
    @pairlink = Pairlink.find(params[:id])
    @pairlink.destroy

    respond_to do |format|
      format.html { redirect_to :action=>'index' }
      format.json { head :no_content }
    end
  end

    def destroy_all
    Pairlink.delete_all

    respond_to do |format|
      format.html { redirect_to :action=>'index' }
      format.json { head :no_content }
    end
  end

  def auth
    name = "admin"
    pass = "ogakiheadgears"

    authenticate_or_request_with_http_basic() do |n, p|
      n == name &&
        p == pass
    end
  end


end
