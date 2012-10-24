# encoding: UTF-8

class HomesController < ApplicationController
  require 'addressable/uri'
  before_filter :auth, :only => "index" #basic認証


  def index
    @your_tamki_url = ""
    @pairlinks = Pairlink.where(:state => 1).limit(100).order("created_at DESC")

    unless Pairlink.exists?
      #render :text => "no data"
    end

  end

  def create
    native_url = params[:native_url]

    #berify paramaters 方針:最低限のblankは面倒なのでここではじいて、あとはto_create内でstate処理にする
    if status = Pairlink.critical_validation(native_url)
      render :json => {:result => 'ERROR' , :tamaki_url => status } and return
    end

    #processing
    @your_tamki_url = Pairlink.to_create(native_url)

    #response 
    @response = {
      :result => 'OK',
      :tamaki_url => @your_tamki_url
    }
    render :json => @response.to_json
  end

  def jump
    @pairlink = Pairlink.find_by_tamaki_url(params[:id])
    if @pairlink
      redirect_url = Addressable::URI.parse(@pairlink.url)
      redirect_url = redirect_url.normalize.to_s
      redirect_to(redirect_url)
    else
      redirect_to root_path
    end
  end

private
  
  #authentication
  def auth
    name = "tamaki"
    pass = "tamaki"

    authenticate_or_request_with_http_basic() do |n, p|
      n == name &&
        p == pass
    end
  end

end
