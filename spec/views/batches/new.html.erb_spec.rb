require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    assign(:batch, Batch.new(
      name: "MyString",
      course: nil
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", batches_path, "post" do

      assert_select "input[name=?]", "batch[name]"

      assert_select "input[name=?]", "batch[course_id]"
    end
  end
end
