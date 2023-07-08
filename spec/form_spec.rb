# frozen_string_literal: true

RSpec.describe "Form build" do
  let(:user_struct) { Struct.new(:name, :job, keyword_init: true) }

  it "should generate base wrapper" do
    user = user_struct.new name: "alex", job: "programmer"
    form = HexletCode.form_for user do |f|
    end
    expect(form).to eq('<form action="#" method="post"></form>')
    form = HexletCode.form_for user, url: "example" do |f|
    end
    expect(form).to eq('<form action="example" method="post"></form>')
  end
end
