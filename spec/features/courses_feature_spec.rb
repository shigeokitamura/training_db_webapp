require 'spec_helper'

base_title = 'Training DB Webapp'

describe 'Top' do
  specify 'should get top' do
    visit '/'
    expect(page).to have_title "Top | #{base_title}"
  end
end

describe 'Search' do
  specify 'should get search' do
    visit '/search'
    expect(page).to have_title "Search | #{base_title}"
  end
end

describe 'New' do
  specify 'should get new' do
    visit '/new'
    expect(page).to have_title "New | #{base_title}"
  end
end
