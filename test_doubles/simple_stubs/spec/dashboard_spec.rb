require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#todays_posts" do
    it "returns posts created today" do
      posts_published_today = double("published_today")

      # My answer
      # dashboard = Dashboard.new(posts: posts_published_today)
      # allow(dashboard).to receive(:todays_posts).and_return(posts_published_today)
      # result = dashboard.todays_posts
      # expect(result).to eq(posts)

      # Modified Thoughtbot Solution (posted solution was incorrect, changed .posts to todays_posts)
      expect(Post).to receive(:today).and_return(posts_published_today)
      dashboard = Dashboard.new(posts: Post.all)

      expect(dashboard.todays_posts).to eq posts_published_today
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end
