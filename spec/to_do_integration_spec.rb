require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_expectations,false)

describe('the path to the add list', {:type => :feature}) do
  it('shows a page with a form to create a new list. On submit, shows a page containing a list of lists.') do
    visit('/list/new')
    fill_in('name', :with => 'Chores')
    click_button('submit')
    expect(page).to have_content('Chores')
  end

end
