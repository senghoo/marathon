require "rails_helper"

RSpec.describe MarathonService do
  let(:service) {MarathonService.new}
  let(:declarations) {service.declarations}
  let(:contributions) {service.contributions 'senghoo'}

  it "should be get marathon members" do
    expect(declarations).to include('senghoo')
  end

  it "can get contributions" do
    expect(contributions.url).to eq("https://github.com/users/senghoo/contributions")
    expect(contributions.contributions.keys.last).to eq(Date.today)
    expect(contributions.current_streak).to be_kind_of Integer
    expect(contributions.longest_streak).to be_kind_of Integer
  end
end
