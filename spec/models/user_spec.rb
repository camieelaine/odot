require 'rails_helper'

RSpec.describe User do
	let(:valid_attributes) {
		{
		first_name: "Jane", 
		last_name: "Doe",
		email: "jane@gmail.com",
		password: "jane1234",
     	password_confirmation: "jane1234"
		}
	}
	context "validations" do
		let(:user) { User.new(valid_attributes)}

		before do
			User.create(valid_attributes)
		end
		
		it "requires an email" do
			expect(user).to validate_presence_of(:email)
		end

		it "requires a unique email" do
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires a unique email (case insensitive)" do
			user.email="JANE@GMAIL./COM"
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires the email address to look like an email" do 
			user.email = "jane"
			expect(user).to_not be_valid
		end
		
	end

	describe "#downcase_email" do
		it "makes the email attribute lower case" do
			user = User.new(valid_attributes.merge(email: "JANE@GMAIL.COM"))
			user.downcase_email
			expect(user.email).to eq("jane@gmail.com")
		end
	end

	it "downcases an email before saving" do
			user = User.new(valid_attributes)
			user.email = "JANE@GMAIL.COM"
			expect(user.save).to be_truthy
			expect(user.email).to eq("jane@gmail.com")
		end

end
