require 'spec_helper'
 
describe ProteinsDatatable do
    describe '#initialize' do
        params = {
            :sSortDir_0 => 'asc', :iSortCol_0 => "1", :iDisplayStart => "26",
            :iDisplayLength => "50", :sSearch => "", :sEcho => "1"
        }
        let(:view) { double("view", :params => params) }
        let(:datatable) { ProteinsDatatable.new(view) }
         
        it 'receives a view as context' do
            datatable.view.should eql view
        end
    end
     
    describe 'delegations' do
        params = {
        :sSortDir_0 => 'asc', :iSortCol_0 => "1", :iDisplayStart => "26",
        :iDisplayLength => "50", :sSearch => "", :sEcho => "1"
        }
        let(:view) { double("view", :params => params) }
        let(:datatable) { ProteinsDatatable.new(view) }
     
        it 'delegates params call to view' do
            view.expects(:params).returns({:sEcho => 4})
            datatable.params
        end
         
        it 'delegates h call to view' do
            view.expects(:h).returns('foo')
            datatable.h
        end
         
        it 'delegates link_to to view' do
            view.expects(:link_to).returns('foo')
            datatable.link_to
        end
         
        it 'delegates number_to_currency to view' do
            view.expects(:number_to_currency).returns('foo')
            datatable.number_to_currency
        end
    end
     
    describe '#as_json' do
        params = {
        :sSortDir_0 => 'asc', :iSortCol_0 => "1", :iDisplayStart => "26",
        :iDisplayLength => "50", :sSearch => "", :sEcho => "1"
        }
        let(:view) { double("view", :params => params) }
        let(:datatable) { ProteinsDatatable.new(view) }
         
        it 'returns a json hash' do
            datatable.as_json.should be_a Hash
        end
         
        it 'has jquery.dataTables required keys' do
            datatable.as_json.keys.should include(:sEcho, :iTotalRecords, :iTotalDisplayRecords, :aaData)
        end
    end
     
    context 'helper methods' do
        params = {
        :sSortDir_0 => 'asc', :iSortCol_0 => "1", :iDisplayStart => "26",
        :iDisplayLength => "50", :sSearch => "", :sEcho => "1"
        }
        let(:view) { double("view", :params => params) }
        let(:datatable) { ProteinsDatatable.new(view) }
         
        describe '#sort_direction' do
            it 'returns the value of params[:sSortDir_0]' do
                datatable.send(:sort_direction).should eql view.params[:sSortDir_0]
                datatable.send(:sort_direction).should be_a String
            end
        end
         
        describe '#sort_column' do
            it 'returns value of params[:iSortCol_0]' do
                datatable.send(:sort_column).should be_a String
            end
        end
         
        describe '#page' do
            it 'returns an integer that represents a page number from pagination' do
                datatable.send(:page).should be_a Integer
            end
        end
         
        describe '#per_page' do
            it 'returns the value of params[:iDisplayLength] converted to Integer' do
                datatable.send(:per_page).should eql 50
            end
             
            it 'defaults to 25 if value is not provided or equal to 0' do
                view.stubs(:params).returns({ :iDisplayLength => "0" })
                datatable.send(:per_page).should eql 25
                 
                view.stubs(:params).returns({ :iDisplayLength => "" })
                datatable.send(:per_page).should eql 25
            end
        end
         
        describe '#fetch_orders' do
            before :each do
                Order.should_receive(:where).with(any_args()).at_least(:once)
            end
         
            it 'returns an ActiveRecord::Relation of Order objects' do
                datatable.send(:fetch_orders).should be_a ActiveRecord::Relation
            end
         
            it 'calls private methods :sort_column and :sort_direction' do
                datatable.should_receive(:sort_column)
                datatable.should_receive(:sort_direction)
                datatable.send(:fetch_orders)
            end
         
            it 'calls private methods :page and :per_page' do
                datatable.should_receive(:per_page)
                datatable.should_receive(:page)
                datatable.send(:fetch_orders)
            end
         
            it 'performs search on :id, :purchased_at, :account, :transaction_id, :total columns' do
                view.stubs(:params).returns({ :sSearch => "1234" })
                datatable.send(:fetch_orders)
            end
        end
     
        describe '#orders' do
            it 'calls :fetch_orders the first time' do
                datatable.should_receive(:fetch_orders)
                datatable.send(:orders)
            end
         
            it 'caches the value and does not call :fetch_orders if nothing changed' do
                datatable.send(:orders)
                datatable.should_not_receive(:fetch_orders)
                datatable.send(:orders)
            end
        end
         
        describe '#data' do
            it 'returns an Array' do
                datatable.send(:data).should be_a Array
            end
        end
    end
end
