# frozen_string_literal: true

RSpec.describe TopUp do
  it "has a version number" do
    expect(TopUp::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(TopUp.process(1, 2)).to eq(true)
  end
end
