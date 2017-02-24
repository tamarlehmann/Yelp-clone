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
    visit '/'
    click_link 'Sign in'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'test123'
    click_button 'Log in'
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'


     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

end
