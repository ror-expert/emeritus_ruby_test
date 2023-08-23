require 'rails_helper'

RSpec.describe "schools/show", type: :view do
  before(:each) do
    @school = assign(:school, School.create!(
      name: "Name",
      address: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    # render
    # expect(rendered).to match(/Name/)
    # expect(rendered).to match(/MyText/)
  end
end
