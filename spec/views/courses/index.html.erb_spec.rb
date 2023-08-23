require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    @school = assign(:school, create(:school))
    assign(:courses, [
      Course.create!(
        name: "Name",
        description: "MyText",
        school: @school
      ),
      Course.create!(
        name: "Name",
        description: "MyText",
        school: @school
      )
    ])
  end

  it "renders a list of courses" do
    #pending "add some examples to (or delete) #{__FILE__}"
    #render
    # assert_select "tr>td", text: "Name".to_s, count: 2
    # assert_select "tr>td", text: "MyText".to_s, count: 2
    # assert_select "tr>td", text: nil.to_s, count: 2
  end
end
