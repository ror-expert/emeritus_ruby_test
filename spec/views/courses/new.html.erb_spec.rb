require 'rails_helper'

RSpec.describe "courses/new", type: :view do
  before(:each) do
    @school = assign(:school, create(:school))
    assign(:course, Course.new(
      name: "MyString",
      description: "MyText",
      school: @school
    ))
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", school_courses_path(@school.id), "post" do

      assert_select "input[name=?]", "course[name]"

      assert_select "textarea[name=?]", "course[description]"

    end
  end
end
