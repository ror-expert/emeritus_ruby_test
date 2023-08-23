require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    school = create(:school)
    @course = create(:course, school: school)

    assign(:batch, Batch.new(
      name: "MyString",
      course: @course
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", course_batches_path(@course), "post" do

      assert_select "input[name=?]", "batch[name]"

    end
  end
end
