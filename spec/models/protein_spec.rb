require 'spec_helper'

describe Protein do
    let(:taxon) { FactoryGirl.create(:taxon) }
    before { @protein = FactoryGirl.create(:protein, taxon_id: taxon.id) }
    subject { @protein }

    it { should respond_to(:protein_accession) }
    it { should respond_to(:protein_sequence) }
    it { should respond_to(:name) }
    it { should respond_to(:taxon) }
    it { should respond_to(:protein_has_domains) }
    it { should respond_to(:domainlist) }
    it { should respond_to(:domains) } 

    it { should be_valid }

    describe "when protein_accession is not present" do
        before { @protein.protein_accession = '' }

        it { should_not be_valid }
    end

    describe "when protein_accession is already used" do
        it "should not be valid" do
            FactoryGirl.build(:protein, protein_accession: @protein.protein_accession).should_not be_valid
        end
    end

    describe "when taxon_id is not present" do
        before { @protein.taxon_id = '' }

        it { should_not be_valid }
    end

    describe "when protein_sequence contains invalid characters" do
        before { @protein.protein_sequence = "nrnerniae000000000000" }
        it { should_not be_valid }
    end

end
