require 'spec_helper'

describe Taxon do
    let(:taxon) { FactoryGirl.create(:taxon) }
    let(:protein1) { FactoryGirl.create(:protein, :taxon_id => taxon.id) }
    let(:protein2) { FactoryGirl.create(:protein, :taxon_id => 53) }
    subject { taxon }

    it { should respond_to(:taxon_name) }
    it { should respond_to(:NCBIid) }
    it { should respond_to(:NCBIlineage) }
    it { should respond_to(:proteins) }

    describe " taxon.id should equal taxon.proteins.first.taxon_id" do
        its(:id) { should eq protein1.taxon_id }
        its(:id) { should_not eq protein2.taxon_id }
    end

end
