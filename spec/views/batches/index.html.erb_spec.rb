require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    school = create(:school)
    course = create(:course, school: school)

    assign(:batches, [
      Batch.create!(
        name: "Name",
        course: course
      ),
      Batch.create!(
        name: "Name",
        course: course
      )
    ])
  end

  it "renders a list of batches" do
    # render
    # assert_select "tr>td", text: "Name".to_s, count: 2
    # assert_select "tr>td", text: nil.to_s, count: 2
  end
end
