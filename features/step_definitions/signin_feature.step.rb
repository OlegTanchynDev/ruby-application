Given /^Enter the sign in page$/ do
  @driver = Selenium::WebDriver.for :chrome, switches: %w[--incognito]
  @driver.manage().window().maximize()
  @driver.get 'http://127.0.0.1:3000/users/sign_in'
  sleep(2)
end

Then /^Need to write an email$/ do
  @driver.find_element(name: "user[email]").send_keys("otanc@softserveinc.com")
  sleep(1)
end

Then /^Need to write a password$/ do
  @driver.find_element(name: "user[password]").send_keys("Password!")
  sleep(1)
end

Then /^Need to check a checkbox$/ do
  @driver.find_element(id: "user_remember_me").click
  sleep(1)
end

And /^Need to click the Log in button$/ do
  @driver.find_element(name: "commit").submit
end
