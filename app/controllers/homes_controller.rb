# encoding: UTF-8

class HomesController < ApplicationController
  require 'addressable/uri'
  before_filter :auth, :only => "index" #basic認証


  def index
    @your_tamki_url = ""

    @pairlinks = Pairlink.find(:all,:limit=>100)

    unless Pairlink.exists?
      #render :text => "no data"
    end

  end

  def create
    native_url = params[:native_url]

    #TODO berify paramaters
    if state_params = validates_integration(native_url)
      @response = {
      :result => 'OK',
      :tamaki_url => state_params
    }
    render :json => @response.to_json
    #
    logger.debug "----owattete hoshiiiii-----"
      
    end
    #not blank
    #include http:
    #without javascript

    @your_tamki_url = Pairlink.to_create(native_url)
    unless @your_tamki_url
      @your_tamaki_url = "うまく生成できなかった。正直すまんかった。もう一回試して欲しい"
    end

#    @pairlinks = Pairlink.where(true)
#    render "index"

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
      redirect_to :action=>'index'
    end
  end

private
  
  def auth
    name = "tamaki"
    pass = "tamaki"

    authenticate_or_request_with_http_basic() do |n, p|
      n == name &&
        p == pass
    end
  end

  def validates_integration(params)
    return "おまえ空だぞ、なにしてんの" if params.blank?
    return "javascriptとか書くなよ、なにしてんの" if params.to_s =~ /<script>/ || /javascript/

    return false #all clear
  end

end
