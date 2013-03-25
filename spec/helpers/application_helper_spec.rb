require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page name" do
      full_title("foo").should =~ /foo/
    end

    it "should includes the base name" do
      full_title("foo").should =~ /^ThousandSoft/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end
