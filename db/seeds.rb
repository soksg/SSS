# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: 'Admin@mail.com',
    password: 'aaaaaa'
)

members = Member.create!(
  [
    {email: 'olivia@test.com', name: 'Olivia', password: 'password'},
    {email: 'james@test.com', name: 'James', password: 'password'},
    {email: 'lucas@test.com', name: 'Lucas', password: 'password'}
  ]
)

Post.create!(
  [
    {name: '図書館', address: '東京都千代田区丸の内１丁目', longitude: 35.6814999, latitude: 139.7611213, url: 'url.example1.com', phone_number: '○○○-○○○○-○○○', opening_hour: '10:00~20:00', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/library-ga2d16ba88_1920.jpg"), filename:"library-ga2d16ba88_1920.jpg"), description: 'おしゃれな図書館です。', member_id: members[0].id },
    {name: 'コワーキングスペース', address: '大阪府大阪市北区梅田３丁目１−１', longitude: 34.7024854, latitude: 135.4937619, url: 'url.example2.com', phone_number: '○○○-○○○○-○○○', opening_hour: '10:00~20:00', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/coworking-space-in-gurgaon-gd8e923af7_1920.jpg"), filename:"coworking-space-in-gurgaon-gd8e923af7_1920.jpg"), description: 'おしゃれなコワーキングスペースです',member_id: members[1].id },
    {name: 'カフェ', address: '東京都新宿区新宿１丁目８', longitude: 35.6880912, latitude: 139.7090349, url: 'url.example3.com', phone_number: '○○○-○○○○-○○○', opening_hour: '10:00~20:00', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cafe-g7fc971d08_1920.jpg"), filename:"cafe-g7fc971d08_1920.jpg"), description: 'おしゃれなカフェです', member_id: members[2].id }
  ]
)