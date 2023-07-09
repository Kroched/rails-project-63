# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "Tag build" do
  it "success build single tag without params" do
    tag = HexletCode::Tag.build("img")
    expect(tag).to eq("<img>")
  end

  it "success build single tag with params" do
    tag = HexletCode::Tag.build("img", src: "example.com")
    expect(tag).to eq("<img src=\"example.com\">")
  end

  it "success build pair tag without params" do
    tag = HexletCode::Tag.build("div")
    expect(tag).to eq("<div></div>")
  end

  it "success build pair tag with params and block" do
    tag = HexletCode::Tag.build("div", class: "btn w-100") { "example" }
    expect(tag).to eq("<div class=\"btn w-100\">example</div>")
  end

  it "should raise error with unknown tag" do
    expect { HexletCode::Tag.build("undefined_tag") }.to raise_error(HexletCode::Tag::AbstractTag::UnknownTagError)
  end
end
