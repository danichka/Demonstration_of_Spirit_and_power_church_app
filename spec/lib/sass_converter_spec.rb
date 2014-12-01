describe "SassConverter" do
  it "should return hash when conversion is succeeded" do
    correct_data = SassConverter.convert("#{Rails.root}/spec/fixtures/valid_variables.css.scss")
    expect(correct_data).to eq({ screen_xs_max: "767px",
                                 screen_md_max: "1199px",
                                 background_color: "rgba(255, 255, 255, 0.95) !important",
                                 border_width: 0,
                                 width: "90px",
                                 line_height: 1.5,
                                 screen_us_max: "$screen_md_max + 300",
                                 screen_sm_max: "400px" })
  end

  it "should raise error if variable is not correct" do
    converted_data = SassConverter.convert("#{Rails.root}/spec/fixtures/invalid_variables.css.scss")
    expect(converted_data).to eq({})
  end
end