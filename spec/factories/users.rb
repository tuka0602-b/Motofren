FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { "tester@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
    password_confirmation { "dottle-nouveau-pavilion-tights-furze" }
  end
end
