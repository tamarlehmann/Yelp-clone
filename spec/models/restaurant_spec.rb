require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    @user = User.create(email: 'test@test.com', password: 'test123')
    @user.restaurants.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  context "associations" do
    it 'belongs to a user and has many reviews' do
      should have_many(:reviews)
      should belong_to(:user)
    end
  end

end
