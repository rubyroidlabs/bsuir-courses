require "yaml"
require_relative "../libs/token"

describe Token do
  describe ".get" do
    it "not nil" do
      expect(Token.get).not_to eq(nil)
    end
  end
end
