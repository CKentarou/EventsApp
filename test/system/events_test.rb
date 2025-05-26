require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "/event/:idページを表示する" do
    event = FactoryBot.create(:event)
    visit event_url(event)
  
    assert_selector "h1", text: event.name
  end

  test "/event/new/ページを表示する" do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
    assert_selector "h2", text: "イベント作成"
  end
end
