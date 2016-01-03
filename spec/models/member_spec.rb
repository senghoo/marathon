require 'rails_helper'

RSpec.describe Member, type: :model do
  senghoo = Member.find_by_name "senghoo"
  expect(senghoo.current_streak).to be_kind_of Integer
end
