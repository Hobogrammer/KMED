require 'test_helper'
require 'gaiji'

describe "Gaiji" do

  describe "should find gaiji codes in definitions and replace them with the unicode counter part" do

    it "for Chujiten" do
      code_definition = ""
      gaiji = Gaiji.new("CHIJITEN")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Daijirin" do
      code_definition = "つぐ [1] 【[GAIJI=wA740]榔・[GAIJI=wA740]榔子】"
      gaiji = Gaiji.new("DAIJIRIN")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Daijisen" do
      code_definition = "い‐さん【遺産】ヰ‐
      [GAIJI=wC373]死後に残した財産。法律的には、人が死亡当時持っていた所有権・債権・債務も含む全財産をいう。相続財産。[GAIJI=wC374]前代の人が残した業績。「文化—」"
      gaiji = Gaiji.new("DAIJISEN")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Genius" do
      code_definition = ""
      gaiji = Gaiji.new("GENIUS")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Kojien" do
      code_definition = ""
      gaiji = Gaiji.new("KOJIEN")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Meikyojj" do
      code_definition = ""
      gaiji = Gaiji.new("MEIKYOJJ")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end

    it "for Meikyou" do
      code_definition = "ぎょう‐せき【業績】ゲフ─[GAIJI=wB03E]名[GAIJI=wB03F]"
      gaiji = Gaiji.new("MEIKYOU")
      assert_equal("", gaiji.de_gaiji(code_sentence))
    end
  end
end
