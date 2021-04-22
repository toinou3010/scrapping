require 'rspec'
require_relative '../lib/Dark-Trader.rb'


describe "test the realisation of the array" do
    
  it "should return hash, and hash is not nil" do    
        expect(create_hash).not_to be_nil 
        expect(create_hash()).is_a? Array
    end
end
