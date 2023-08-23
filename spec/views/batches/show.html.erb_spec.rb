require 'rails_helper'

RSpec.describe "batches/show", type: :view do
  before(:each) do
    school = create(:school)
    course = assign(:course, create(:course, school: school))

    @batch = assign(:batch, Batch.create!(
      name: "Name",
      course: course
    ))
    assign(:students, [])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
