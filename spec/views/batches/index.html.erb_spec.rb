require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    assign(:batches, [
      Batch.create!(
        name: "Name",
        course: nil
      ),
      Batch.create!(
        name: "Name",
        course: nil
      )
    ])
  end

  it "renders a list of batches" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
