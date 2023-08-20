require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        name: "Name",
        description: "MyText",
        school: nil
      ),
      Course.create!(
        name: "Name",
        description: "MyText",
        school: nil
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
