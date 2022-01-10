# Test Doubles / Verifying Mailers With Test Doubles

Hey there! We're [thoughtbot](https://thoughtbot.com), a design and
development consultancy that brings your digital product ideas to life.
We also love to share what we learn.

This coding exercise comes from [Upcase](https://thoughtbot.com/upcase),
the online learning platform we run. It's part of the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course and is just one small sample of all
the great material available on Upcase, so be sure to visit and check out the rest.

## Exercise Intro

Now that you've learned how to use stubs, mocks, spies, and fakes, it's time to pull it all together.

Most Rails applications have at least one mailer, and test doubles are a great way to verify that a mailer is being used without relying on information in the mailer, such as the subject.

In this exercise, you'll test-drive using a mailer from the `Signup` class, using stubs, mocks, spies, and fakes as appropriate to verify that the mailer is used correctly.

## Instructions

To start, you'll want to clone and run the setup script for the repo

    git clone git@github.com:thoughtbot-upcase-exercises/verifying-mailers-with-test-doubles.git
    cd verifying-mailers-with-test-doubles
    bin/setup

After running `bin/setup`, edit `spec/signup_spec.rb`.

Use stubs, mocks, and spies as appropriate to test-drive a delivery of the `SignupMailer`. After creating the account and user, the `Signup#save` method should call `SignupMailer.signup(account: account, user: user)`. Consider in each case whether you actually need to verify a message using a mock or spy, or if you can simply use a stub.

Next, use TDD and test doubles to verify that `Signup#save` writes an info level message to the log after delivering the mailer. The logged message should include the subject from the delivered mailer. Consider whether to use stubs, mocks, spies, fakes, or some combination of several.

## Tips and Tricks

Review [our summary of test doubles on the Weekly Iteration](https://upcase.com/videos/stubs-mocks-spies-and-fakes), as well as the [rspec-mocks guide](https://github.com/rspec/rspec-mocks#rspec-mocks--).

## Featured Solution

Check out the [featured solution branch](https://github.com/thoughtbot-upcase-exercises/verifying-mailers-with-test-doubles/compare/featured-solution#toc) to
see the approach we recommend for this exercise.

## Forum Discussion

If you find yourself stuck, be sure to check out the associated
[Upcase Forum discussion](https://forum.upcase.com/t/test-doubles-verifying-mailers-with-test-doubles/4614)
for this exercise to see what other folks have said.

## Next Steps

When you've finished the exercise, head on back to the
[Test Doubles](https://thoughtbot.com/upcase/test-doubles) course to find the next exercise,
or explore any of the other great content on
[Upcase](https://thoughtbot.com/upcase).

## License

verifying-mailers-with-test-doubles is Copyright © 2015-2018 thoughtbot, inc. It is free software,
and may be redistributed under the terms specified in the
[LICENSE](/LICENSE.md) file.

## Credits

![thoughtbot](https://presskit.thoughtbot.com/assets/images/logo.svg)

This exercise is maintained and funded by
[thoughtbot, inc](http://thoughtbot.com/community).

The names and logos for Upcase and thoughtbot are registered trademarks of
thoughtbot, inc.
