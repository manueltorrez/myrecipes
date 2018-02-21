require 'test_helper'

class ChefsShowTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Manuel", email: "manuel@example.com",
            password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "boiled water", description: "great boiled water", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "boiled covfefe", description: "@donaldtrump")
    @recipe2.save
  end

  def "should get chefs show" do 
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_math @chef.chefname, response.body
  end

end
