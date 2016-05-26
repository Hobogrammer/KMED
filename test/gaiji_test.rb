require 'test_helper'
require 'gaiji'

describe "Gaiji" do

  describe "should replace gaiji codes in strings and replace them with the unicode counter part" do

    it "for Chujiten" do
      gaiji_string = "[GAIJI=wA37D]"
      gaiji = Gaiji.new("CHUJITEN")
      assert_equal("®", gaiji.de_gaiji(gaiji_string))
    end

    it "for Daijirin" do
      gaiji_string = "[GAIJI=wA740]"
      gaiji = Gaiji.new("DAIJIRIN")
      assert_equal("桄", gaiji.de_gaiji(gaiji_string))
    end

    it "for Daijisen" do
      gaiji_string = "[GAIJI=wC373]死後に残した財産"
      gaiji = Gaiji.new("DAIJISEN")
      assert_equal("①死後に残した財産", gaiji.de_gaiji(gaiji_string))
    end

    #it "for Genius" do
      #gaiji_string = ""
      #gaiji = Gaiji.new("GENIUS")
      #assert_equal("", gaiji.de_gaiji(gaiji_string))
    #end

    it "for Kojien" do
      gaiji_string = "[GAIJI=wA456]"
      gaiji = Gaiji.new("KOJIEN")
      assert_equal("噦", gaiji.de_gaiji(gaiji_string))
    end

    it "for Meikyojj" do
      gaiji_string = "[GAIJI=wA36D]"
      gaiji = Gaiji.new("MEIKYOJJ")
      assert_equal("Ⅲ", gaiji.de_gaiji(gaiji_string))
    end

    it "for Meikyou" do
      gaiji_string = "[GAIJI=wA17A][GAIJI=wA178]"
      gaiji = Gaiji.new("MEIKYOU")
      assert_equal("㋘㋖", gaiji.de_gaiji(gaiji_string))
    end
  end
end
