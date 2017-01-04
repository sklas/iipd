require 'spec_helper'

describe Domain do
    let(:domain) { FactoryGirl.create(:domain) }
    subject { domain }

    it { should respond_to(:pfam_accession) }
    it { should respond_to(:name) }
    it { should respond_to(:clan) }
    it { should respond_to(:description) }
    it { should respond_to(:reverse_protein_has_domains) }
    it { should respond_to(:proteinlist) }
    it { should respond_to(:proteins) }

    it { should be_valid }
end
