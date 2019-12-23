require "rails_helper"

RSpec.describe ApplicationController, :type => :controller do

  controller do
    def index
      render :plain => I18n.locale.to_s
    end

    def custom
      required_login
    end

    def error
      render_404
    end
  end


  it "switches locale" do
    get :index, :params => {:locale => :jp}
    expect(response.body).to eq "jp"
  end

  it "requires login" do
    routes.draw { get "custom" => "anonymous#custom" }
    get :custom
    expect(response).to redirect_to(root_url)
  end

  it "renders 404" do
    routes.draw { get "error" => "anonymous#error" }
    get :error
    expect(response).to have_http_status(:not_found)
  end
end