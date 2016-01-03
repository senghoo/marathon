require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        :name => "MyText",
        :home => "MyText",
        :github_id => 1
      ),
      Member.create!(
        :name => "MyText",
        :home => "MyText",
        :github_id => 1
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
