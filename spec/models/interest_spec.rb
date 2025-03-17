# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interest, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:users) }
  end
end
