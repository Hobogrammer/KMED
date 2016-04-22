require 'test_helper'
require 'gaiji'
require 'pry-nav'

describe "Gaiji" do

  it "should return '' for dictionary CHUJITEN when given [GAIJI=]" do

  end
  
  it "should return '' for dictionary CHUJITEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary CHUJITEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJIRIN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJIRIN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJIRIN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJISEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJISEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary DAIJISEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary KOJIEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary KOJIEN when given [GAIJI=]" do

  end

  it "should return '' for dictionary KOJIEN when given [GAIJI=]" do
    gaiji = Gaiji.new("MEIKYOU")
    unicode_char = gaiji.convert("[GAIJI=wA628]")
    assert_equal("玕", unicode_char)
  end

  it "should return 'Ⅰ' for dictionary MEIKOJJ when given [GAIJI=wA36B]" do 
    gaiji = Gaiji.new("MEIKOJJ")
    unicode_char = gaiji.convert("[GAIJI=wA36B]")
    assert_equal("Ⅰ", unicode_char)
  end

  it "should return '㋤' for dictionary MEIKOJJ when given [GAIJI=wB322]" do
    gaiji = Gaiji.new("MEIKOJJ")
    unicode_char = gaiji.convert("[GAIJI=wB322]")
    assert_equal("㋤", unicode_char)
  end

  it "should return '⑳' for dictionary MEIKOJJ when given [GAIJI=wB03A]" do
    gaiji = Gaiji.new("MEIKOJJ")
    unicode_char = gaiji.convert("[GAIJI=wB03A]")
    assert_equal("⑳", unicode_char)
  end

  it "should return '₁' for dictionary MEIKYOU when given [GAIJI=wA170]" do
    gaiji = Gaiji.new("MEIKYOU")
    unicode_char = gaiji.convert("[GAIJI=wA170]")
    assert_equal("₁", unicode_char)
  end

  it "should return '玕' for dictionary MEIKYOU when given [GAIJI=wA628]" do
    gaiji = Gaiji.new("MEIKYOU")
    unicode_char = gaiji.convert("[GAIJI=wA628]")
    assert_equal("玕", unicode_char)
  end

  it "should return '餛' for dictionary MEIKYOU when given [GAIJI=wA77D]" do
    gaiji = Gaiji.new("MEIKYOU")
    unicode_char = gaiji.convert("[GAIJI=wA77D]")
    assert_equal("餛", unicode_char)
  end

end
