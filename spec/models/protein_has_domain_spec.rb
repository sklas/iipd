require 'spec_helper'

describe ProteinHasDomain do
    let(:taxon) { FactoryGirl.create(:taxon) }
    let(:protein) { FactoryGirl.create(:protein, taxon_id: taxon.id) }

    subject { protein }

    it { should be_valid }
end
