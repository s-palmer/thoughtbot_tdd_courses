# Test Doubles / Testing Flexible Interactions With Fakes

Hey there! We're [thoughtbot](https://thoughtbot.com), a design and
development consultancy that brings your digital product ideas to life.
We also love to share what we learn.

This coding exercise comes from [Upcase](https://thoughtbot.com/upcase),
the online learning platform we run. It's part of the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course and is just one small sample of all
the great material available on Upcase, so be sure to visit and check out the rest.

## Exercise Intro

Stubs, mocks, and spies can be used to test almost any interaction between two objects. However, the rigid nature of message expectations sometimes can lead to brittle tests.

Further, stubs are not terribly convenient or intuitive to share between tests, so it's easy to end up with duplicated code or awkward extractions.

Lastly, for some interactions, the failure messages you receive from stubs, mocks, and spies may not tell you much about what you're doing wrong.

For these rare cases, there's one last type of test double: a fake.

Unlike previous doubles, you don't create fakes by using `double`. In fact, there's no explicit support for fakes in RSpec at all. That's because fakes are just plain old Ruby objects which you inject into the object you're testing, so no framework is necessary (or possible).

This means that you can make your fakes behave however you want. It also means you have to implement them entirely yourself.

Here's an example of an awkward test using stubs and spies:

``` ruby
describe SearchForm  do
  describe "#results" do
    it "builds a search and returns its results" do
      search = double("search")
      results = double("results")
      allow(Search).to receive(:new).and_return(search)
      allow(search).to receive(:author_word).and_return(search)
      allow(search).to receive(:title_word).and_return(search)
      allow(search).to receive(:to_a).and_return(results)
      form = SearchForm.new(title: "one two", author: "Billy Idol")

      expect(form.results).to eq(results)
      expect(search).to have_received(:author_word).with("Billy")
      expect(search).to have_received(:author_word).with("Idol")
      expect(search).to have_received(:title_word).with("one")
      expect(search).to have_received(:title_word).with("two")
    end
  end
end
```

The order of most of these methods is unimportant, but the last method (`to_a`) must be called last. Although RSpec allows you to specify the order of invocations, this situation is tricky: you can either enforce a strict order in the tests, even though it should be flexible, or you can allow any order, which would allow for a broken implementation.

Here's the same test using a fake:

``` ruby
describe SearchForm  do
  describe "#results" do
    it "builds a search and returns its results" do
      search = FakeSearch.new
      allow(Search).to receive(:new).and_return(search)
      form = SearchForm.new(title: "one two", author: "Billy Idol")

      expect(form.results.criteria).to eq(
        author_words: %w(Billy Idol),
        title_words: %w(one two)
      )
    end
  end
end
```

This reads much more clearly, but there's a downside; you now need to implement `FakeSearch`:

``` ruby
class FakeSearch
  def initialize(criteria = nil)
    @criteria = criteria || {
      author_words: [],
      title_words: []
    }
  end

  def author_word(word)
    new_words = @criteria[:author_words] + [word]
    self.class.new(@criteria.merge(author_words: new_words))
  end

  def title_word(word)
    new_words = @criteria[:title_words] + [word]
    self.class.new(@criteria.merge(title_words: new_words))
  end

  def results
    Results.new(@criteria)
  end

  class Results
    attr_reader :criteria

    def initialize(criteria)
      @criteria = criteria
    end
  end
end
```

Fakes are costly in terms of development time, so it's best to try testing with stubs, mocks, and spies first. If you can't find a comfortable way to use them, try a fake.

In this exercise, you'll use a fake to test interactions with a common and awkward object: Ruby's `Logger`.

## Instructions

To start, you'll want to clone and run the setup script for the repo

    git clone git@github.com:thoughtbot-upcase-exercises/testing-flexible-interactions-with-fakes.git
    cd testing-flexible-interactions-with-fakes
    bin/setup

After running `bin/setup`, edit `spec/signup_spec.rb` and take a look at the stubs and spies in place for testing logger interactions.

Change the log level for a successful signup from `:info` to `:debug`, changing the test first so as to follow test-driven development. Notice the failure message you receive after updating the expectation.

Replace the logger stubs and spies in `spec/signup_spec.rb` with a new fake logger. You can add the fake as a new class in `spec/support/fake_logger.rb`.

Change the log level for a failed signup from `:error` to `:fatal`. Again, change the test first so that you see the failure message. Adjust the fake until the failure message makes it very clear what you must change to make the test pass, and then make the test pass.

## Tips and Tricks

Check out our Weekly Iteration episode on [Stubs, Mocks, Spies, and Fakes](https://upcase.com/videos/stubs-mocks-spies-and-fakes) for more detail on Fakes, and how they compare to stubs, mocks, and spies.

## Featured Solution

Check out the [featured solution branch](https://github.com/thoughtbot-upcase-exercises/testing-flexible-interactions-with-fakes/compare/featured-solution#toc) to
see the approach we recommend for this exercise.

## Forum Discussion

If you find yourself stuck, be sure to check out the associated
[Upcase Forum discussion](https://forum.upcase.com/t/test-doubles-testing-flexible-interactions-with-fakes/4613)
for this exercise to see what other folks have said.

## Next Steps

When you've finished the exercise, head on back to the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course to find the next exercise,
or explore any of the other great content on
[Upcase](https://thoughtbot.com/upcase).

## License

testing-flexible-interactions-with-fakes is Copyright © 2015-2018 thoughtbot, inc. It is free software,
and may be redistributed under the terms specified in the
[LICENSE](/LICENSE.md) file.

## Credits

![thoughtbot](https://presskit.thoughtbot.com/assets/images/logo.svg)

This exercise is maintained and funded by
[thoughtbot, inc](http://thoughtbot.com/community).

The names and logos for Upcase and thoughtbot are registered trademarks of
thoughtbot, inc.
