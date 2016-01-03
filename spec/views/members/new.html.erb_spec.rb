require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      :name => "MyText",
      :home => "MyText",
      :github_id => 1
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "textarea#member_name[name=?]", "member[name]"

      assert_select "textarea#member_home[name=?]", "member[home]"

      assert_select "input#member_github_id[name=?]", "member[github_id]"
    end
  end
end
