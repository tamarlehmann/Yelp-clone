require 'rails_helper'

RSpec.describe Review, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # describe Review, type: :model do
    it "is invalid if the rating is more than 5" do
      review = Review.new(rating: 10)
      expect(review).to have(1).error_on(:rating)
    end
  # end

  context 'associations' do
    it 'belongs to user and restaurant' do
      should belong_to(:user)
      should belong_to(:restaurant)
    end
  end

end
