require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "DictTc" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://dictionary.reference.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_dict_tc" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "q").click
    @driver.find_element(:id, "q").clear
    @driver.find_element(:id, "q").send_keys "cloud"
    @driver.find_element(:css, "input[type=\"submit\"]").click
    # Warning: waitForTextPresent may require manual changes
    !60.times{ break if (@driver.find_element(:css, "BODY").text =~ /^[\s\S]*cloud[\s\S]*$/ rescue false); sleep 1 }
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert.text
  ensure
    @accept_next_alert = true
  end
end
