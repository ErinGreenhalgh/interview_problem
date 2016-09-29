require "rails_helper"

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:social_security_number) }

  context "with correct values" do
    scenario "validates social security number and email" do
      user = User.new(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "012345678")
      expect(user.save).to be true
    end
  end

  context "with incorrect values" do
    scenario "does not validate social security number that is the incorrect length" do
      user = User.new(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "01234")
      expect(user.save).to be false
    end

    scenario "does not validate social security number that has anythign but numbers" do
      user = User.new(first_name: "steve", last_name: "jobs", email: "steve@apple.com", social_security_number: "01234abcd")

      expect(user.save).to be false
    end

    scenario "does not validate incorrectly formatted email" do
      user = User.new(first_name: "steve", last_name: "jobs", email: "bad_email", social_security_number: "012345678")
      expect(user.save).to be false
    end
  end
end
