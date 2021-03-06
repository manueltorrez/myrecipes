require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Manuel", email: "manuel@example.com",
            password: "password", password_confirmation: "password")
  end

  test 'reject an invalid edit' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "manuel@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.card-title'
    assert_select 'div.card-block'
  end

  test 'accept valid signup' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "manuel1", email: "manuel1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "manuel1", @chef.chefname
    assert_match "manuel1@example.com", @chef.email
  end

end
