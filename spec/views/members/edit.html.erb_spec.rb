require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :name => "MyText",
      :home => "MyText",
      :github_id => 1
    ))
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "textarea#member_name[name=?]", "member[name]"

      assert_select "textarea#member_home[name=?]", "member[home]"

      assert_select "input#member_github_id[name=?]", "member[github_id]"
    end
  end
end
