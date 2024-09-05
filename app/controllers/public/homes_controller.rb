class Public::HomesController < ApplicationController
before_action :authenticate_user!, except: [:top, :about, :entrance, :save]
  def top
  end  
  
  def about
  end  
  
  def mypage
  end  
  
  def entrance
    @top = Album.last_week.limit(1)
  end
  
  def save
  end  
  
end
