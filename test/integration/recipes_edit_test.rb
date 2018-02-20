require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Manuel", email: "manuel@example.com",
            password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "boiled water", description: "great boiled water", chef: @chef)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } }
    assert_template 'recipes/edit'
    assert_select 'h2.card-title'
    assert_select 'div.card-block'
  end

  test "Successfully edit a recipe" do 
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_recipe_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_recipe_description } }
    assert_redirected_to @recipe
    #follow_redirect!    -it's the same as assert_redirect_to
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_recipe_description, @recipe.description
  end

end
