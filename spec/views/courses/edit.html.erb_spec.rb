require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  before(:each) do
    @school = assign(:school, create(:school))
    @course = assign(:course, Course.create!(
      name: "MyString",
      description: "MyText",
      school: @school
    ))
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", school_course_path(@school, @course), "post" do

      assert_select "input[name=?]", "course[name]"

      assert_select "textarea[name=?]", "course[description]"

    end
  end
end
