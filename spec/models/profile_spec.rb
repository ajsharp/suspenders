require 'spec_helper'

describe Profile do
  context "on create" do
    it { should validate_presence_of :user_id }
  end

  context "associations" do
    it { should belong_to :user }
  end
end
