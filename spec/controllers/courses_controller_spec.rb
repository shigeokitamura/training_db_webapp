require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  render_views

  let(:base_title) { 'Training DB Webapp' }

  it "get top" do
    get :top
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>Top | #{base_title}<\/title>/i)
  end

  it "get search" do
    get :search
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>Search | #{base_title}<\/title>/i)
  end

end