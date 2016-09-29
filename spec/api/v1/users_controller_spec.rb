require "rails_helper"

RSpec.describe "api::v1::users_controller" do
  context "with valid information" do
    scenario "can create a user object, showing only name, email, and id" do
      user_params = {first_name: "steve",
                     last_name:  "jobs",
                     email:      "steve@apple.com",
                     social_security_number: "123456789" }
      post "/api/v1/users", user: user_params
      expect(response.status).to be 201
      data = JSON.parse(response.body)
      expect(data.keys).to eq(["id", "first_name", "last_name", "email"])
      expect(data["id"]).to             eq 1
      expect(data["first_name"]).to eq user_params[:first_name]
      expect(data["last_name"]).to  eq user_params[:last_name]
      expect(data["email"]).to      eq user_params[:email]
    end

    scenario "can show all the users" do
      user_one   = User.create(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "012345678")
      user_two   = User.create(first_name: "lenny", last_name: "kravitz", email: "lenny@example.com", social_security_number: "012345678")
      user_three = User.create(first_name: "ada", last_name: "lovelace", email: "ada@lovelace.com", social_security_number: "012345678")

      get "/api/v1/users"

      expect(response).to be_success
      data = JSON.parse(response.body)
      expect(data.count).to eq 3

      one   = data[0]
      two   = data[1]
      three = data[2]

      expect(one["first_name"]).to   eq user_one.first_name
      expect(two["first_name"]).to   eq user_two.first_name
      expect(three["first_name"]).to eq user_three.first_name
    end

    scenario "can show a single user" do
      user = User.create(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "012345678")

      get "/api/v1/users/#{user.id}"

      expect(response).to be_success
      data = JSON.parse(response.body)
      expect(data.keys).to eq(["id", "first_name", "last_name", "email"])
      expect(data["first_name"]).to eq user.first_name
    end
  end

  context "with invalid information" do
    scenario "renders an error message when trying to create a user" do
      bad_params =  {email:      "bad email",
                     social_security_number: "1234" }
      error_message = "First name can't be blank. Last name can't be blank. Social security number is the wrong length (should be 9 characters). Email is invalid"
      post '/api/v1/users', user: bad_params
      expect(response.status).to eq 400
      data = JSON.parse(response.body)
      expect(data["message"]).to eq error_message
    end

    scenario "renders an error message when trying to show a user" do
      user = User.create(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "012345678")
      bad_id = 12
      error_message = "The user you requested could not be found."

      get "/api/v1/users/#{bad_id}"

      expect(response.status).to eq 404
      error = JSON.parse(response.body)
      expect(error["message"]).to eq error_message
    end
  end
end
