After("@backoffice") do
  # As all our back office tests start with logging in we need to ensure that
  # as each back office scenario finishs that we have logged out. Rather than
  # peppering our steps with calls to click the log out link, we have this hook
  # which is called after every scenario tagged with @backoffice do it.

  # TODO: Have attempted to essentially make these same calls using the
  # SitePrism elements in MastheadSection however it seems to go into an
  # infinite loop of exposing the menu, clicking the btn, and nothing happening
  # but the menu closing again. So fo now just using Capybara directly until
  # have more time to dive deeper.
  find("#navTabButtonUserInfoLinkId").click

  # TODO: The commented out command should work, as my double checking says they
  # are pointing to the same thing. However using it just seems to close the
  # menu. The second uncommented version both clicks and signs us out, but I
  # cannot spot the difference why!
  # find("#navTabButtonUserInfoSignOutId").click
  find("a", text: "Sign out").click

  # Have this expect clause here to both force the tests to wait for Dynamics
  # to confirm we have signed out, and check we actually have. If we don't
  # it causes subsequent tests to fail.
  expect(page.has_content?("You've signed out of your account")).to be(true)
end
