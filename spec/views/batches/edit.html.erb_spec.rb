require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  before(:each) do
    @batch = assign(:batch, Batch.create!(
      name: "MyString",
      course: nil
    ))
  end

  it "renders the edit batch form" do
    render

    assert_select "form[action=?][method=?]", batch_path(@batch), "post" do

      assert_select "input[name=?]", "batch[name]"

      assert_select "input[name=?]", "batch[course_id]"
    end
  end
end
