require "spec_helper"

describe "Signing up" do
  it "allows a user to sign up for the site and creates the object in the database" do
    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First Name", with: "Jane"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: "jane@gmail.com"
    fill_in "Password", with: "jane1234"
    fill_in "Password (again)", with: "jane1234"
    click_button "Sign Up"

    expect(User.count).to eq(1)
  end
  
end