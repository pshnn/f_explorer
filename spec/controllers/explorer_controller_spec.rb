# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExplorerController do
  render_views

  describe 'GET #explore' do
    before do
      VCR.use_cassette('controller/explorer') do
        get :explore
      end
    end

    it 'returns status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders template' do
      expect(response).to render_template(:explore)
    end
  end
end
