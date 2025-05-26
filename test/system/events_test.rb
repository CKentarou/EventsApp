require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "/event/:idページを表示する" do
    event = FactoryBot.create(:event)
    visit event_url(event)
  
    assert_selector "h1", text: event.name
  end
end
