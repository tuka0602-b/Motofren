FactoryBot.define do
  factory :participation do
    permission { false }
    user
    recruitment
  end
end
