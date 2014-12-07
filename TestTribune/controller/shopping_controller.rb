require 'rails'
require 'active_support'
require 'active_resource'
require 'active_record'
require 'yaml'
require_relative '../db/models/database_model'

class ShoppingListController < ApplicationController
  
  before_filter :verify_user_logged_in
  
  def index
    from = params[:from].blank? ? "January 1, 1975" : Time.zone.local_to_utc(DateTime.strptime(params[:from], '%B %d, %Y %H:%M %p'))
    to = params[:to].blank? ? "December 31, 3000" : Time.zone.local_to_utc(DateTime.strptime(params[:to], '%B %d, %Y %H:%M %p'))
    select = params[:select_fields].nil? ?  "*" : params[:select_fields]
    conditions = "username = '#{@username}' and id in (select order_id from items where bought = 'false') "
    conditions << "and items.created_at between '#{from}' and '#{to}' unless params[:from].blank? && params[:to].blank?" unless params[:from].blank? && params[:to].blank?
    unless params[:from].blank? && params[:to].blank?
      @shopping_lists = ShoppingList.all(:select => select, :conditions => conditions)
      
      page = params[:page].to_i
      page = 1 if page < 1
      @shopping_lists = @shopping_lists[(page - 1) * 10, 10]
      get_list_totals
    end
    
    def for_store
      @shopping_lists = ShoppingList.all(:conditions => "username = '#{@username}' and store = '#{params[:store]}' and id in (select order_id from items where bought = 'false')")
      page = params[:page].to_i
      page = 1 if page < 1
      @shopping_lists = @shopping_lists[(page - 1) * 10, 10]
      get_list_totals
    end
    
    
    def show
      @shopping_list = ShoppingList.find(params[:id])
      unless @shopping_list
        render :action => "not_found"
      else
        @total = 0
        @remaining = 0
        @shopping_list.items.each{|item| @total = @total + item.cost; @remaining = @remaining + item.cost if bought == false}
        @total_in_dollars = @total / 100.0
        @remaining_in_dollars = @remaining / 100.0
      end
    end
    
    
    def new
      @shopping_list = ShoppingList.new
      @total_in_dollars = 0
      render :action => :show
    end
    
    
    def save
      @shopping_list = ShoppingList.find(params[:id]) rescue nil
      @shopping_list = ShoppingList.new if !@shopping_list
      @shopping_list.store = params[:shopping_list][:store]
      @shopping_list.description = params[:shopping_list][:description]
      @shopping_list.username = params[:username]
      @shopping_list.save
      @total = 0
      @remaining = 0
      
      params[:shopping_list][:items].values.each do |item_params|
        item_id = item_params[:id]
        if item_params[:_delete]
          item = Item.find(item_id)
          item.destroy
        else
          item = Item.find(item_id) rescue Item.new
          item.description = item_params[:description]
          item.amount = item_params[:amount]
          item.bought = item_params[:bought]
          item.save
          @total = @total + item.cost
          @remaining = @remaining + item.cost if bought == false
        end
      end
      
      @total_in_dollars = @total / 100.0
      @remaining_in_dollars = @remaining / 100.0
      render :action => show
    end
    
    def expensive_lists
      @shopping_lists = ShoppingList.all(:conditions => "username = '#{@username}' and (select sum(cost) from items where order_id = #{params[:id]}) > #{params[:limit]}")
      get_list_totals
    end
    
    def get_list_totals
      @totals_in_dollars = {}
      @shopping_lists.each { |list|
        @totals_in_dollars[list.id] = 0
        list.items.each {|item| @totals_in_dollars[list.id] = @totals_in_dollars[list.id] + item.cost / 100.0}
      }
    end
  end
end