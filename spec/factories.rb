FactoryGirl.define do
  factory :user do
    name     "Eric Gowens"
    email    "egowens@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
