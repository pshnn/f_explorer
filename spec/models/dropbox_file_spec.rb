# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DropboxFile do
  describe '#last_modified' do
    let(:params) { { 'client_modified' => '2018-09-07T09:52:58Z' } }
    let(:expected_result) { 'Fri Sep  7 09:52:58 2018' }

    subject { DropboxFile.new(params).last_modified }

    it('returns formatted datetime') { expect(subject).to eq expected_result }
  end

  describe '#size' do
    let(:params) { { 'size' => 1160249 } }
    let(:expected_result) { '1.11 MiB' }

    subject { DropboxFile.new(params).size }

    it ('returns formatted datetime') { expect(subject).to eq expected_result }
  end
end
