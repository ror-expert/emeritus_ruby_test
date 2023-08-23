require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  before(:each) do
    school = create(:school)
    @course = create(:course, school: school)

    @batch = assign(:batch, Batch.create!(
      name: "MyString",
      course: @course
    ))
  end

  it "renders the edit batch form" do
    render

    assert_select "form[action=?][method=?]", course_batch_path(@course, @batch), "post" do

      assert_select "input[name=?]", "batch[name]"

    end
  end
end
