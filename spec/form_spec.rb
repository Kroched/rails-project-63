# frozen_string_literal: true

require_relative "spec_helper"

User = Struct.new(:name, :job, keyword_init: true)

RSpec.describe "Form builder" do
  before { @user = User.new name: "alex", job: "programmer" }

  it "should generate base wrapper" do
    form = HexletCode.form_for(@user) {}
    expect(form).to eq('<form action="#" method="post"></form>')
    form = HexletCode.form_for(@user, url: "example") {}
    expect(form).to eq('<form action="example" method="post"></form>')
  end

  it "should generate form with one input" do
    form = HexletCode.form_for(@user) { |f| f.input :name }
    expected = File.read("spec/fixtures/form/one_input.txt").strip!
    expect(form).to eq(expected)
  end

  it "should generate form with multiple inputs" do
    form = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
    end
    expected = File.read("spec/fixtures/form/multi_input.txt").strip!
    expect(form).to eq(expected)
  end

  it "should raise error on non existing field" do
    expect do
      HexletCode.form_for(@user) { |f| f.input :undefined }
    end.to raise_error(NoMethodError)
  end

  it "should generate form with default submit" do
    expected = File.read("spec/fixtures/form/with_submit.txt").strip!
    form = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
      f.submit
    end
    expect(form).to eq(expected)
  end

  it "should generate form with custom value submit" do
    expected = File.read("spec/fixtures/form/with_submit_and_custom_value.txt").strip!
    form = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
      f.submit "custom"
    end
    expect(form).to eq(expected)
  end
end
