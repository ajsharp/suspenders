require 'spec_helper'

describe PublicPagesController do
  describe "GET home /" do
    before :each do
      get :home
    end

    it { should respond_with        :success }
    it { should render_template     'home.html.haml' }
    it { should render_with_layout  'application' }
    it { should route(:get, "/").to(:controller => 'public_pages', :action => 'home') }

  end
end
