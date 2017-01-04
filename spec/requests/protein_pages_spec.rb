require 'spec_helper'

describe "ProteinPages" do
    subject { page }

    describe "browse page" do
        before { visit proteins_path }

        it { should have_title(full_title('Browse')) }
        it { should have_selector('h1', text:'Browse') }

    end

end
