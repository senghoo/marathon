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
    expect(contributions.contributions.size).to eq(366)
  end

  it "is sync infomations" do
    service.sync
    senghoo = Member.find_by name: 'senghoo'
    expect(senghoo).to be_kind_of Member
    expect(senghoo.contributions.size).to eq(366)
  end
end
