require 'rails_helper'

RSpec.describe "attendances/new", type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
      :user => nil,
      :event => nil,
      :attendance_status => "MyString"
    ))
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do

      assert_select "input#attendance_user_id[name=?]", "attendance[user_id]"

      assert_select "input#attendance_event_id[name=?]", "attendance[event_id]"

      assert_select "input#attendance_attendance_status[name=?]", "attendance[attendance_status]"
    end
  end
end
