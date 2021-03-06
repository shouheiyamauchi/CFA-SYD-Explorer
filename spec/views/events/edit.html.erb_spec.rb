require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :event_name => "MyString",
      :event_description => "MyText",
      :event_location => "MyString",
      :event_cost => "9.99"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_event_name[name=?]", "event[event_name]"

      assert_select "textarea#event_event_description[name=?]", "event[event_description]"

      assert_select "input#event_event_location[name=?]", "event[event_location]"

      assert_select "input#event_event_cost[name=?]", "event[event_cost]"
    end
  end
end
