# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body "may the force be with you"
    views 0
    max_views 4
    token "3joK32mzwnIHg3VNniu9RS9YI27Ux7sZM"
  end
end
