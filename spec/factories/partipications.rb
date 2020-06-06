FactoryBot.define do
  factory :partipication do
    permission { false }
    user
    recruitment
  end
end
