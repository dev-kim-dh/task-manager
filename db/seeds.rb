# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GithubUser.all.each(&:destroy)
User.all.each(&:destroy)

user = User.create(
  name: "duho",
  mail: "dev.kimduho@gmail.com",
  password: "password"
)

user.reload.create_github_user(
  remote_id: 105_637_809,
  github_name: "k-duho",
  github_email: "dev.kimduho@gmail.com",
  avatar_url: "test",
  profile_url: "test",
  auth_token: "test"
)
