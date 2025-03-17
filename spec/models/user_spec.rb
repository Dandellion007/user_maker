# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should define_enum_for(:gender).with_values(%i[male female]) }
    it { should validate_numericality_of(:age).only_integer }
    it { should validate_numericality_of(:age).is_in(1..90) }
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:interests) }
    it { should have_and_belong_to_many(:skills) }
  end

  describe '#user_full_name' do
    subject { user.user_full_name }

    let(:user) { build(:user) }

    context 'when surname present' do
      let(:user_full_name) { "#{user.surname} #{user.name} #{user.patronymic}" }

      it { is_expected.to eq(user_full_name) }
    end

    context 'when surname empty' do
      let(:user) { build(:user, surname: nil) }
      let(:user_full_name) { "#{user.name} #{user.patronymic}" }

      it { is_expected.to eq(user_full_name) }
    end
  end
end
