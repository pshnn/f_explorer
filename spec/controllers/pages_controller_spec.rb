# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController do
  render_views

  describe 'GET #home' do
    before do
      VCR.use_cassette('controller/pages') do
        get :home
      end
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders template' do
      expect(response).to render_template(:home)
    end
  end
end
