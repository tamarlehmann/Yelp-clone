require 'rails_helper'

RSpec.describe User, type: :model do

  context 'associations' do
    it 'should have many restaurants and reviews' do
      should have_many(:restaurants)
      # should have_many(:reviews)
    end

    it { is_expected.to have_many :reviewed_restaurants }
  end
end
