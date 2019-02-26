require "./spec_helper"

describe RethinkORM::Validators do
  context "Unique" do
    it "invalidates models with non-unique fields" do
      special_snowflake = Snowflake.create!(shape: "fernlike stellar dendrites", meltiness: 0)
      less_special_snowflake = Snowflake.new(shape: "fernlike stellar dendrites", meltiness: 2)

      special_snowflake.valid?.should be_true
      less_special_snowflake.valid?.should be_false

      less_special_snowflake.errors[0].to_s.should eq "Snowflake shape should be unique"
    end

    it "validates if the model is the same" do
      special_snowflake = Snowflake.create!(shape: "a super special snowflake", meltiness: 5)
      same_flake = Snowflake.find(special_snowflake.id)

      same_flake.should_not eq nil
      unless same_flake.nil?
        same_flake.meltiness = 1000
        same_flake.valid?.should be_true
      end

      special_snowflake.valid?.should be_true
    end

    it "accepts a transform block for the field" do
      special_snowflake = Snowflake.create!(personality: "gentle")
      louder_snowflake = Snowflake.new(personality: "GENTLE")

      special_snowflake.valid?.should be_true
      louder_snowflake.valid?.should be_false

      louder_snowflake.errors[0].to_s.should eq "Snowflake personality should be unique"
      special_snowflake.valid?.should be_true
    end
  end
end