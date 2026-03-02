require "faker"

image_path = Rails.root.join("db/seeds/images/test_image.jpg")

5.times do |n|
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "test1234",
    encrypted_password: "test1234"
  )

  prefecture_ids = Prefecture.ids.sample(5)

  5.times do |i|
    post = user.posts.build(
      title: Faker::Food.dish,
      body: Faker::Food.description,
      prefecture_id: prefecture_ids[i],
      category_id: Category.ids.sample
    )

    File.open(image_path) do |file|
      post.image = file
    end

    post.save!
  end
end

puts "ダミーデータ作成"
