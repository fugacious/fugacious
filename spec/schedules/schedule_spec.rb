require 'rails_helper'

describe "Schedule" do
  include Shoulda::Whenever

  let(:whenever) { Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s) }

  it "calls message_task:check_expiry daily" do
    expect(whenever).to schedule_rake("message_task:check_expiry")
      .every(:day)
  end
end