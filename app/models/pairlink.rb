# encoding: UTF-8

class Pairlink < ActiveRecord::Base
  attr_accessible :tamaki_url, :url ,:digested_hash ,:state
  validates_uniqueness_of :tamaki_url
  validates :url, :length => {:maximum => 200 } 


  def self.to_create(_url)
    pair = Pairlink.new
    pair.url = _url
    pair.digested_hash = Digest::SHA1.hexdigest(_url)
    pair.state = pair.set_to_states

    if tamaki_url = pair.find_hash
      return tamaki_url
    end
    unless tamaki_url = pair.gen_tamaki_url
      return false
    end
    
    pair.tamaki_url = tamaki_url  
    pair.save!

    return pair.tamaki_url
  end

  #本来model_varidatesで行う事をメソッドで二度手間かけてエラーjsonを作る目的
  def self.critical_validation(param)
    return "URLを入力してください" if param.blank?
    return "sorry!!this URL is longer!!" if param.length >= 200

    return false #成功
  end

  def self.delete_all
    pairlinks = Pairlink.all
    pairlinks.each do |pair|
      pair.destroy
    end
  end



  def find_hash
    pair = self
    hash = pair.digested_hash

    unless Pairlink.exists?(:digested_hash => hash)
      return false
    else #hash exists
      return Pairlink.find_by_digested_hash(hash).tamaki_url
    end
  end


  def gen_tamaki_url
    const_tamaki = ["た","ま","き"]
    url = self.url

    code = (
      Array.new(rand(32)+1) do 
       const_tamaki[rand(3)]
      end  
    ).join

    unless Pairlink.exists?(:tamaki_url => code)
      return code
    else
      return false
    end  
  end

  def set_to_states
    return 0  if self.url.blank?
    return 0  if self.url.to_s =~ /javascript:.*/
    return 0  if self.url.to_s =~ /.*<script>.*/
    return 0  if self.url.to_s =~ /.*\.rar/
    return 0  if self.url.to_s =~ /.*\.zip/
    return 0  if self.url.to_s =~ /.*\.exe/
    return 0  if self.url.to_s =~ /.*\.lzh/
    return 0  unless self.url.to_s =~ /http.*/

    return 1 #all clear
  end

end




