require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :event_name => "Event Name",
        :event_description => "MyText",
        :event_location => "Event Location",
        :event_cost => "9.99"
      ),
      Event.create!(
        :event_name => "Event Name",
        :event_description => "MyText",
        :event_location => "Event Location",
        :event_cost => "9.99"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Event Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Event Location".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
