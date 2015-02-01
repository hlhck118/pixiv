# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Illustration.delete_all
User.delete_all
User.create(
    email: "thanhvt1609@gmail.com",
    password: "12345678",
    password_confirmation: "12345678"
)

Restriction.delete_all
Restriction.create(
    name: "All ages"
)
Restriction.create(
    name: "R-18"
)
Restriction.create(
    name: "R-18G"
)

PrivacyLevel.delete_all
PrivacyLevel.create(
    name: "Public"
)
PrivacyLevel.create(
    name: "My pixiv only"
)
PrivacyLevel.create(
    name: "Private"
)