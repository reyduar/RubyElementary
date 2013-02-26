



class ShoppingListController < ApplicationController
  before_filter :verify_user_logged_in
  def index
    from = params[:from].blank? ? "January 1, 1975" : Time.zone.local_to_utc(DateTime.strptime(params[:from], '%B %d, %Y %H:%M %p'))
    to = params[:to].blank? ? "December 31, 3000" : Time.zone.local_to_utc(DateTime.strptime(params[:to], '%B %d, %Y %H:%M %p'))
    select = params[:select_fields].nil? ?  "*" : params[:select_fields]
    conditions = "username = '#{@username}' and id in (select order_id from items where bought = 'false') "
    conditions << "and items.created_at between '#{from}' and '#{to}' unless params[:from].blank? && params[:to].blank?" 

    unless params[:from].blank? && params[:to].blank?
      
    
      
      
      
     
    end
    
    
    
   
    
   
    
    
    
  
    
    
    
    
    
    
   
    
    
    
   
end