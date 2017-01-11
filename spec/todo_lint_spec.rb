# frozen_string_literal: true
require "spec_helper"

RSpec.describe TodoLint do
  it "has a version number" do
    system "git status"
    system "git diff"
    expect(TodoLint::VERSION).to be_a String
  end
end
