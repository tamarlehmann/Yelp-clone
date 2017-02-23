def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def add_restaurant
  click_link('Add a restaurant')
  fill_in('Name', with: 'KFC')
  fill_in('Description', with: 'Southern Fried Chicken')
  click_button('Create Restaurant')
end
