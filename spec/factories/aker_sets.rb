FactoryGirl.define do
  factory :aker_set, class: 'Aker::Set' do
    sequence(:name) { |n| "Set #{n}" }

    after(:create) do |set, evaluator|
      set.set_default_permission('user@here.com')
    end

    factory :set_with_materials do

      transient do
        materials_count 5
      end

      after(:create) do |set, evaluator|
        set.set_default_permission('user@here.com')
        evaluator.materials_count.times { set.materials << create(:aker_material) }
      end

    end
  end
end
