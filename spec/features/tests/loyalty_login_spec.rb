require './lib/requires'

feature 'Login Module' do
  include VerificationHelpers
  include LoginPage
  include AdminPage
  include LandingPage

  before(:each) do
    visit '/'
    @account = '0000'
    @username = '000000@000000.com'
    @password = '00000000000000000'
  end

  it 'should sign in loyaltyplus' do
    login(@username, @password)
    within '.primary_wrap' do
      has_text? '500friends'
    end
    sleep 1
  end

  it 'should go to test automation account' do
    login(@username, @password)
    find_account(@account)
    # binding.pry
    account_name = find(:xpath, "//*[@id='account_name']", wait: 2)
    account_name.text eq 'Nearsoft Automation'
    sleep 1
  end

  after(:each) do
    logout(@username)
  end
end