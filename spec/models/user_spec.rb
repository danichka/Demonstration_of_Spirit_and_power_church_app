require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create user with valid params" do
    expect { FactoryGirl.create(:user) }.to change(User, :count).by(1)
  end
end
