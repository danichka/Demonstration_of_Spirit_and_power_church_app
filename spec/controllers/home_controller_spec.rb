require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #landing" do
    it "responds successfully" do
      get :landing, locale: :ru
      expect(response).to be_success
    end

    it "renders the landing template" do
      get :landing, locale: :ru
      expect(response).to render_template("landing")
    end
  end
end
