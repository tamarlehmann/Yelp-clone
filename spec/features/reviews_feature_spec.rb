require 'rails_helper'

feature 'reviewing' do
  # before do
  #   sign_up
  #   add_restaurant
  # end
  before do
    @user = User.create(email: 'test@test.com', password: 'test123')
    @restaurant = @user.restaurants.create(name: 'KFC')
  end

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     save_and_open_page
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'


     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

end
