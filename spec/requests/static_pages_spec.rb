require 'spec_helper'

describe "StaticPages" do
    subject { page }
    
    shared_examples_for "all static pages" do
        it { should  have_selector('h1', text: heading) }
        it { should have_title(full_title(page_title)) }

        # Make hrefs when routed
        it { should have_link('Search') }
        it { should have_link('Domains') }
        it { should have_link('Blast') }
        it { should have_link('by keyword') }
        it { should have_link('About') }


#        it { should have_link('Browse', href: proteins_path) }
        it { should have_link('Home', href: root_path) }
        it { should have_link('Contact', href: contact_path) }
        it { should have_link('Help', href: help_path) }
    end

    describe "Homepage" do
        before { visit root_path }
        let(:page_title)    { '' }
        let(:heading)       { 'IIPD' }

        it_should_behave_like "all static pages"

        it { should_not have_title('|') }

    end
    
    describe "Contac page" do
        before { visit contact_path }
        let(:page_title)    { 'Contact' }
        let(:heading)       { 'Contact' }

        it_should_behave_like "all static pages"
    end

    describe "Help page" do
        before { visit help_path }
        let(:page_title)    { 'Help' }
        let(:heading)       { 'Help' }

        it_should_behave_like "all static pages"
    end

end
