require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      :user => nil,
      :event => nil,
      :attendance_status => "MyString"
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do

      assert_select "input#attendance_user_id[name=?]", "attendance[user_id]"

      assert_select "input#attendance_event_id[name=?]", "attendance[event_id]"

      assert_select "input#attendance_attendance_status[name=?]", "attendance[attendance_status]"
    end
  end
end
