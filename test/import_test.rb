# -*- encoding : utf-8 -*-
require 'test_helper'
require 'import'

class StubbedLogger
  def debug(message)
  end
end

describe 'ImportHandler' do

  let(:import) { ImportHandler.new(StubbedLogger.new) }

  it 'should process sentence metadata' do
    import_sentence_meta = "独立後のいまもアメリカの保護下にあり、経済的にも軍事的にもこれに依存している。  <フルメタル・パニック！揺れるイントゥ・ザ・ブルー(新装版)<フルメタル・パニック！(新装版)> (富士見ファンタジア文庫)(賀東 招二;四季 童子)>"

    expected_sentence = "独立後のいまもアメリカの保護下にあり、経済的にも軍事的にもこれに依存している。"
    expected_title = "フルメタル・パニック！揺れるイントゥ・ザ・ブルー(新装版)"
    expected_publisher = "富士見ファンタジア文庫"
    expected_author = "賀東 招二;四季 童子"

    import.process_sentence_meta(import_sentence_meta)

    assert(import.sentence.eql?(expected_sentence))
    assert(import.title.eql?(expected_title))
    assert(import.publisher.eql?(expected_publisher))
    assert(import.author.eql?(expected_author))
  end

  describe 'should highlight terms in sentences' do
    describe 'with verbs' do
      it 'ending with -う' do
        sentence_meta = '「……えー、それでは、皆様」 　そろそろ五歳児が退屈してきた様子なのと、場が充分に温まったのを見計らった中井戸氏が、年の功で音頭を取った。   <ノロワレ　怪奇作家真木夢人と幽霊マンション（上）<ノロワレ> (メディアワークス文庫)(甲田 学人)>'.strip
        term = '見計らう(み‐はから・う)'.strip

        expected_result = '\'>見計らった</span>'

        import.set_term(term)
        import.process_sentence_meta(sentence_meta)
        assert(import.sentence.include?("#{expected_result}"))
      end

      it 'ending with -する' do
        sentence_meta = 'ほら、たとえば小学校のとき、同じ少年野球団に属していたけど、他の中学校に行った子とか……」 「…………」 　いる。  <悲鳴伝 (講談社ノベルス)(西尾維新)>'.strip
        term = '属する(しょく・する)'.strip

        expected_result = '\'>属して</span>'

        import.set_term(term)
        import.process_sentence_meta(sentence_meta)
        assert(import.sentence.include?("#{expected_result}"))

        sentence_meta = ' 落ち着いた色の茶髪を無造作にセットしている、スリーピーススーツにステッキなどという変わった格好をしながら、しかし俳優のように様になっている彼は、若いながらもベストセラー作家であり、明確にエキセントリックに属する作家だ。 　  <ノロワレ　怪奇作家真木夢人と幽霊マンション（上）<ノロワレ> (メディアワークス文庫)(甲田 学 人)>'

        expected_result = '\'>属する</span>'

        import.set_term(term)
        import.process_sentence_meta(sentence_meta)
        assert(import.sentence.include?("#{expected_result}"))
      end

      it 'ending with -る(ichidan verbs)' do
        sentence_meta = '集まった視線に、彼は黙って小さく肩を竦めて見せた。  <ノロワレ　怪奇作家真木夢人と幽霊マンション（上）<ノロワレ> (メディアワークス文庫)(甲田 学人)>'.strip
        term = '竦める(すく・む)'

        expected_result = '\'>竦めて</span>'

        import.set_term(term)
        import.process_sentence_meta(sentence_meta)
        assert(import.sentence.include?("#{expected_result}"))
      end
    end
  end
end
