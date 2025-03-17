# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create do
  describe '#execute' do
    subject { described_class.run(params:) }

    let(:base_params) do
      {
        email: 'sherlyn@goldner.example',
        age: 7,
        gender: 'male',
        name: 'Ahmed',
        surname: 'Weber',
        patronymic: 'Emard',
        nationality: 'Czechs',
        country: 'United Arab Emirates'
      }
    end

    shared_examples 'valid result' do
      it 'return correct result' do
        expect(subject).to be_valid
        expect(subject.errors.messages).to be_empty
        expect(subject.result).to be_instance_of(User)
      end
    end

    shared_examples 'invalid result' do
      it 'return correct result' do
        expect(subject).not_to be_valid
        expect(subject.errors.messages).not_to be_empty
      end
    end

    context 'without required params' do
      let(:params) { {} }

      it_behaves_like 'invalid result'
    end

    context 'with required params' do
      let(:params) { base_params }

      it_behaves_like 'valid result'

      it 'return result with passed params' do
        expect(subject.result.attributes).to include(params.stringify_keys)
      end
    end

    context 'with params contain interests' do
      let(:interest) { create(:interest) }
      let(:interests) { [interest.name] }
      let(:params) { base_params.merge(interests:) }

      it_behaves_like 'valid result'

      it 'return user with interest' do
        expect(subject.result.interests).to include(interest)
      end
    end

    context 'with params contain unknown interest' do
      let(:interests) { ['some_interest'] }
      let(:params) { base_params.merge(interests:) }

      it_behaves_like 'valid result'

      it 'return user without interest' do
        expect(subject.result.interests).to be_empty
      end
    end

    context 'with params contain invalid interests' do
      let(:interests) { 'some_interest' }
      let(:params) { base_params.merge(interests:) }

      it_behaves_like 'invalid result'
    end

    context 'with params contain skills' do
      let(:skill1) { create(:skill) }
      let(:skill2) { create(:skill) }
      let(:skills) { "#{skill1.name},#{skill2.name}" }
      let(:params) { base_params.merge(skills:) }

      it_behaves_like 'valid result'

      it 'return user with skills' do
        expect(subject.result.skills).to match_array [skill1, skill2]
      end
    end

    context 'with params contain unknown skills' do
      let(:skills) { 'some_skill' }
      let(:params) { base_params.merge(skills:) }

      it_behaves_like 'valid result'

      it 'return user without skills' do
        expect(subject.result.skills).to be_empty
      end
    end

    context 'with params contain invalid skills' do
      let(:skills) { ['some_skill'] }
      let(:params) { base_params.merge(skills:) }

      it_behaves_like 'invalid result'
    end
  end
end
