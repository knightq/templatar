# encoding: utf-8
require 'spec_helper'

class TestARModel < SuperModel::Base
  def self.column_names
    [:a, :b, :c, :id]
  end

  extend Templatar::ModelAdditions
  has_template methods: [:x, :y]

  def a
  end

  def b
  end

  def c
  end

  def id
  end
end

class Test2ARModel < SuperModel::Base
  def self.column_names
    [:x, :id]
  end

  extend Templatar::ModelAdditions
  has_template

  def x
  end

  def id
  end
end

describe Templatar::ModelAdditions do

  it 'should produce a singleton' do
    TestARModel.template.should === TestARModel.template
  end

  it 'should produce different singletons' do
    TestARModel.template.should_not == Test2ARModel.template
  end

  it 'should inject a template method on the model class' do
    TestARModel.new.should respond_to?(:template)
  end

  context 'template object' do
    let(:model) { TestARModel.template }
    subject { model }

    it { should be_template }

    it "should return column_name + '_TEMPLATE'" do
      model.a.should == 'a__TEMPLATE__'
      model.b.should == 'b__TEMPLATE__'
      model.c.should == 'c__TEMPLATE__'
      model.id.should == '__ID__'
    end

    it "should return method_name + '_TEMPLATE' for custom methods" do
      model.x.should == 'x__TEMPLATE__'
      model.y.should == 'y__TEMPLATE__'
      expect { model.z }.to raise_error(NoMethodError)
    end
  end

  context 'non template object' do
    let(:model) { TestARModel.new }
    subject { model }

    it { should_not be_template }

    it 'should retunr standard value for column_names' do
      model.a.should be_nil
      model.b.should be_nil
      model.c.should be_nil
      model.id.should be_nil
    end
  end
end
