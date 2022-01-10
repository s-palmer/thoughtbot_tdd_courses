require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts visible to the current user" do
      posts = double("posts")
      visible_posts = double("visible_posts")
      user = double("user")
      allow(posts).to receive(:visible_to).with(user).and_return(visible_posts)
      dashboard = Dashboard.new(posts: posts, user: user)

      expect(dashboard.posts).to eq (visible_posts)
    end
  end
end
