# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tom = User.create!(email: "TomGreen@example.com",password: "password",password_confirmation:"password",time_zone: "Eastern Time (US & Canada)")
sarah = User.create!(email: "SarahBrown@example.com",password: "password",password_confirmation:"password",time_zone: "Eastern Time (US & Canada)")
jack = User.create!(email: "JackRed@example.com",password: "password",password_confirmation:"password",time_zone: "Eastern Time (US & Canada)")


users = [tom,sarah,jack];

subjects = ["ruby seminar","java convention","python bootcamp"]
streets = ["University Ave","Bay Street","Yonge Street"]
0.upto(2) do |i|
  0.upto(2) do |j|
  Event.create!(
    subject: users[i].email[/(.*?)@/, 1]+"'s "+subjects[j],
    user_id: users[i].id,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod",
    event_date: Time.now.since(3.month),
    event_price: rand(2 .. 9) * 1000,
    venue: ((i+1)*100).to_s + " " + streets[j] +", Toronto, Ontario"
    )
  end
end