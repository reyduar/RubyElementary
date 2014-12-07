require "rspec"
require File.dirname(__FILE__) + '/../spec_helper'

describe ShoppingListController, "new with a valid menu item" do
  before(:each) do
    ShoppingList.stub!(:new).and_return(@shopping_list = mock_model(ShoppingList, :save=>true))
  end

  def do_create
    post :create, :shopping_list=>{:name=>"shopping_list_1"}
  end

  def do_index
    post :index, :shopping_list=>{:name=>"shopping_list_1"}
  end

  #"January 1, 1975"


  it "should create the menu item" do
    ShoppingList.should_receive(:new).with("name"=>"shopping_list_1").and_return(@shopping_list)
    do_create
  end

  it "should save the menu item" do
    @menu_item.should_receive(:save).and_return(true)
    do_create
  end

  it "should be redirect" do
    do_create
    response.should be_redirect
  end

  it "should assign menu_item" do
    do_create
    assigns(:menu_item).should == @menu_item
  end

  it "should redirect to the index path" do
    do_create
    response.should redirect_to(menu_items_url)
  end
end