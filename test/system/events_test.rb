require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    sign_in_as(FactoryBot.create(:user))
  end

  test "/event/:idページを表示する" do
    event = FactoryBot.create(:event)
    visit event_url(event)
  
    assert_selector "h1", text: event.name
  end

  test "/event/new/ページを表示する" do
    visit new_event_url
    assert_selector "h2", text: "イベント作成"
  end

  test "/event/new/ページでフォームを記入して登録する" do  
    visit new_event_url
    assert_selector "h2", text: "イベント作成"
  
    fill_in "イベント名", with: "テストイベント"
    fill_in "場所", with: "テスト会場"
    fill_in "イベント内容", with: "テストイベントの内容"
  
    start_at = Time.current
    end_at = start_at + 1.hour
  
    start_at_field = "event_start_at"
    select start_at.strftime("%Y"), from: "#{start_at_field}_1i"
    select I18n.l(start_at, format: '%B'), from: "#{start_at_field}_2i" 
    select start_at.strftime("%-d"), from: "#{start_at_field}_3i"
    select start_at.strftime("%H"), from: "#{start_at_field}_4i"
    select start_at.strftime("%M"), from: "#{start_at_field}_5i"
  
    end_at_field = "event_end_at"
    select end_at.strftime("%Y"), from: "#{end_at_field}_1i"
    select I18n.l(end_at, format: '%B'), from: "#{end_at_field}_2i" 
    select end_at.strftime("%-d"), from: "#{end_at_field}_3i"
    select end_at.strftime("%H"), from: "#{end_at_field}_4i"
    select end_at.strftime("%M"), from: "#{end_at_field}_5i"
  
    click_on "イベントを作成"
    assert_selector "div.alert", text: "作成しました"
  end
end
