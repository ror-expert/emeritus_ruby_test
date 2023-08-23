require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  before(:each) do
    @school = assign(:school, create(:school))
    @course = assign(:course, Course.create!(
      name: "Name",
      description: "MyText",
      school: @school
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
