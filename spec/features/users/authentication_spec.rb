require "spec_helper"

describe "Logging In" do
  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "jane1234", password_confirmation: "jane1234")
    visit new_user_session_path
    fill_in "Email Address", with: "jane@gmail.com"
    fill_in "Password", with: "jane1234"
    click_button "Log In"
    
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "diplays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: "jane@gmail.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: "jane@gmail.com")
  end
end