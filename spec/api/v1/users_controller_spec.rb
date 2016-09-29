require "rails_helper"

RSpec.describe "api::v1::users_controller" do
  context "with valid parameters" do
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
  end

  context "with invalid params" do
    scenario "renders an error message" do
      bad_params =  {email:      "bad email",
                     social_security_number: "1234" }
      error_message = "First name can't be blank. Last name can't be blank. Social security number is the wrong length (should be 9 characters). Email is invalid"
      post '/api/v1/users', user: bad_params
      expect(response.status).to eq 400
      data = JSON.parse(response.body)
      expect(data["message"]).to eq error_message
    end
  end
end
