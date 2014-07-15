require 'spec_helper'
  
module ModelSettingsSpec
  extend GenealogyTestModel

  describe "*** Model and table settings ***" do

    before(:each) do
      ModelSettingsSpec.define_test_model_class(has_parents_opts)
    end

    describe 'model with options :father_column => "padre", :mother_column => "madre", :current_spouse => true, :current_spouse_column => "partner", :sex_column => "gender"' do

      let(:has_parents_opts) { {:father_column => "padre", :mother_column => "madre", :current_spouse => true, :current_spouse_column => "partner", :sex_column => "gender"} }

      {:father_column => "padre", :mother_column => "madre", :current_spouse_column => "partner", :sex_column => "gender"} .each do |attr,col_name|

        it "should have #{col_name} as #{attr} attribute" do
          TestModel.send(attr).should == col_name
        end

        it "should have db column named #{col_name}" do
          TestModel.column_names.should include(col_name)
        end

      end

      it "should have 'M' as sex_male_value" do
        TestModel.sex_male_value.should == 'M'
      end

      it "should have 'F' as sex_female_value" do
        TestModel.sex_female_value.should == 'F'
      end

    end

    describe 'model with options: :current_spouse => true' do

      let(:has_parents_opts) { {:current_spouse => true} }

      it "should have current_spouse_column class attribute" do
        TestModel.current_spouse_column.should == 'current_spouse_id'
      end

      it "should have db column named spouse_id" do
        TestModel.column_names.should include("current_spouse_id")
      end

      it "has current_spouse_enabled class attribute true" do
        TestModel.current_spouse_enabled.should be true
      end

    end

    describe 'model with options: :perform_validation => false' do

      let(:has_parents_opts) { {:perform_validation => false} }

      it "has perform_validation class attribute false" do
        TestModel.perform_validation.should be false
      end

    end

    describe 'model without options: defaults' do

      let(:has_parents_opts) { {} }

      [:father, :mother].each do |parent|
        it "should have #{parent}_id as #{parent} column" do
          TestModel.send("#{parent}_column").should == "#{parent}_id"
        end

        it "should have db column #{parent}_id" do
          TestModel.column_names.should include("#{parent}_id")
        end
      end

      it "has perform_validation class attribute true" do
        TestModel.perform_validation.should be true
      end

      it "should not have db column named spouse_id" do
        TestModel.column_names.should_not include("current_spouse_id")
      end
      
      it "has current_spouse_enabled class attribute false" do
        TestModel.current_spouse_enabled.should be false
      end

      it "should not have a current_spouse_column class attribute" do
        expect { TestModel.current_spouse_column }.to raise_error(NoMethodError)
      end

    end

    describe 'model with options: :sex_column => "gender", :sex_values => [1,2]' do

      let(:has_parents_opts) { {:sex_column => "gender", :sex_values => [1,2]} }

      it "has gender as sex column" do
        TestModel.sex_column.should == 'gender'
      end
      it "has an array as sex values" do
        TestModel.sex_values.should be_a_kind_of(Array)
      end
      it "has 1 as male sex value" do
        TestModel.sex_male_value == 1
      end
      it "has 2 as female sex value" do
        TestModel.sex_female_value == 1
      end

    end
  
  end

  describe "model and table settings with wrong options" do

    context "has_parents_opts: {:foo => 'bar' }" do

      let(:has_parents_opts) { {:foo => "bar" } }
      specify { expect { ModelSettingsSpec.define_test_model_class(has_parents_opts) }.to raise_error Genealogy::WrongOptionException }
      
    end

    context "has_parents_opts: {:foo => 'bar' }" do

      let(:has_parents_opts) { {:sex_column => "gender", :sex_values => [1,2,3]} }
      specify { expect { ModelSettingsSpec.define_test_model_class(has_parents_opts) }.to raise_error Genealogy::WrongOptionException }
      
    end

    
  end

end
