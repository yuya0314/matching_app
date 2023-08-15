require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "引数が与えられた場合に'| DRA-MATCH'を末尾に追加した文字列を返すこと" do
      expect(helper.full_title("募集詳細")).to eq("募集詳細 | DRA-MATCH")
    end

    it "引数がスペースの場合に文字列DRA-MATCHを返すこと" do
      expect(helper.full_title(" ")).to eq("DRA-MATCH")
    end

    it "引数がnilの場合に文字列DRA-MATCHを返すこと" do
      expect(helper.full_title(nil)).to eq("DRA-MATCH")
    end
  end
end
