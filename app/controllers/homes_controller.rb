# encoding: UTF-8

class HomesController < ApplicationController
  before_filter :auth, :only => "index" #basic認証


  def index
    @your_tamki_url = ""

    @pairlinks = Pairlink.where(true)

    unless Pairlink.exists?
      #render :text => "no data"
    end

  end

  def create
    native_url = params[:native_url]


    @your_tamki_url = Pairlink.to_create(native_url)
    unless @your_tamki_url
      @your_tamaki_url = "うまく生成できなかった。正直すまんかった。もう一回試して欲しい"
    end

    @pairlinks = Pairlink.where(1)
    render "index"

  end

  def jump
    @pairlink = Pairlink.find_by_tamaki_url(params[:id])
    if @pairlink
      redirect_to(@pairlink.url)
    else
      redirect_to :action=>'index'
    end
  end

private
  
  def auth
    name = "tamaki"
    pass = "c55f951efa54f9182da3bf337ff765e7709a58fa"

    authenticate_or_request_with_http_basic() do |n, p|
      n == name &&
        Digest::SHA.hexdigest(p) == pass
    end
  end



end
