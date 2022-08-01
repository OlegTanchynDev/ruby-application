Given /^Enter the sign up page$/ do
  @driver = Selenium::WebDriver.for :chrome, switches: %w[--incognito]
  @driver.manage().window().maximize()
  @driver.get 'http://127.0.0.1:3000/users/sign_up'
  sleep(2)
end

Then /^Need to fill a name$/ do
  @driver.find_element(name: "user[name]").send_keys("Tanchyn Oleh 2022 Demo")
  sleep(1)
end

Then /^Need to fill an email$/ do
  @driver.find_element(name: "user[email]").send_keys("test2022demo@softserveinc.com")
  sleep(1)
end

Then /^Need to fill a password$/ do
  @driver.find_element(name: "user[password]").send_keys("Password!")
  sleep(1)
end

And /^Need to click the sign up button$/ do
  @driver.find_element(name: "commit").submit
  sleep(1)
end
