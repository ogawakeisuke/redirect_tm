# encoding: UTF-8

class Pairlink < ActiveRecord::Base
  attr_accessible :tamaki_url, :url
  validates_uniqueness_of :tamaki_url


  def self.to_create(_url)
    pair = Pairlink.new

    pair.url = _url
    pair.digested_hash = Digest::SHA1.hexdigest(_url)

    if tamaki_url = pair.find_hash
      return tamaki_url
    end

    unless tamaki_url = pair.gen_tamaki_url
      return false
    end

    pair.tamaki_url = tamaki_url

    unless pair.save!
      return false
    end
    return pair.tamaki_url
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


end




