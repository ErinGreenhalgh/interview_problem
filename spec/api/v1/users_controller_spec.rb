require "rails_helper"

RSpec.describe "api::v1::users_controller" do
  context "with valid parameters" do
    scenario "can create a user object, showing only name, email, and id" do
      user_params = {first_name: "steve",
                     last_name:  "jobs",
                     email:      "steve@apple.com",
                     social_security_number: "123456789" }
      post "/api/v1/users", user: user_params
      expect(response).to be_success #check that 200 is the appropriate response for create
      data = JSON.parse(response.body)
      expect(data.keys).to eq(["id", "first_name", "last_name", "email"])
      epext(data.id).to             eq 1
      expect(data["first_name"]).to eq user_params[:first_name]
      expect(data["last_name"]).to  eq user_params[:last_name]
      expect(data["email"]).to      eq user_params[:email]
    end
  end
end
