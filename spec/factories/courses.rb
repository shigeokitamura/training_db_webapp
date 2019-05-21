FactoryBot.define do
  factory :course do
    course_id { "a-1" }
    course_title { "hoge" }
    topic { "fuga" }
    day_length { 1 }
    price { 0 }
    level_id { 1 }
    category { "piyo" }
  end
end
