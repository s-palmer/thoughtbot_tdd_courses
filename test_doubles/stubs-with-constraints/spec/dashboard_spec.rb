require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts visible to the current user" do
      user = create(:user)
      other_user = create(:user)
      create :post, user: other_user, published: true, title: "published_one"
      create :post, user: other_user, published: true, title: "published_two"
      create :post, user: other_user, published: false, title: "unpublished"
      create :post, user: user, published: false, title: "visible_one"
      create :post, user: user, published: false, title: "visible_two"
      dashboard = Dashboard.new(posts: Post.all, user: user)

      result = dashboard.posts

      expect(result.map(&:title)).to match_array(%w(
        published_one
        published_two
        visible_one
        visible_two
      ))
    end
  end
end
