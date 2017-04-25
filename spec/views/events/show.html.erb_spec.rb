require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :event_name => "Event Name",
      :event_description => "MyText",
      :event_location => "Event Location",
      :event_cost => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Event Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Event Location/)
    expect(rendered).to match(/9.99/)
  end
end
