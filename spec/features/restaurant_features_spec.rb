require 'rails_helper'

feature "restaurants" do
  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
    sign_up
    add_restaurant
    # Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      attach_file("restaurant_image", "spec/MakersLogo.jpeg")
      #fill_in 'description', with: 'Fried Chicken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(page).to have_css 'img'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'

        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  # image = 'spec/fixture/restaurant_test.jpg'
  #     fill_in_restaurant_form(name: restaurant_name, description: restaurant_desc, image: image)
  #     image_element = find('img')
  #     expect(image_element['src']).to include('restaurant_test')

  context 'viewing restaurants' do
  before do
    @user = User.create(email: 'test@test.com', password: 'test123')
    @restaurant = @user.restaurants.create(name: 'KFC')
  end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
        # save_and_open_page

      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{@restaurant.id}"
    end
  end

  context 'editing restaurants' do
    before do
      sign_up
      add_restaurant
    end

      scenario 'let a user edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        click_link 'Kentucky Fried Chicken'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
      end
  end

  context 'deleting restaurants' do
    before do
      sign_up
      add_restaurant
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'must be logged in' do
    scenario 'user cannot add restaurant if logged out' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
