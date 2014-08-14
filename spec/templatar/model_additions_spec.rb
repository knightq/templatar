# encoding: utf-8
require 'spec_helper'

class TestARModel < SuperModel::Base

  def self.column_names
    [:a, :b, :c]
  end

  extend Templatar::ModelAdditions
  has_template

  def a
  end

  def b
  end

  def c
  end

end

describe Templatar::ModelAdditions do

  it 'should inject a template method on the model class' do
    TestARModel.new.should respond_to?(:template)
  end

  context 'template object' do
    let(:model) { TestARModel.template }
    subject { model }

    it { should be_template }

    it "should retunr column_name + '_TEMPLATE'" do
      model.a.should == 'a_TEMPLATE'
      model.b.should == 'b_TEMPLATE'
      model.c.should == 'c_TEMPLATE'
    end
  end

  context 'non template object' do
    let(:model) { TestARModel.new }
    subject { model }

    it { should_not be_template }

    it "should retunr standard value for column_names" do
      model.a.should be_nil
      model.b.should be_nil
      model.c.should be_nil
    end
  end
end
