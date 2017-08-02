class MastheadSection < SitePrism::Section

  # When adding it to your pages use
  # section(:mast_head, MastheadSection, MastheadSection::SELECTOR)
  SELECTOR ||= "#navTabGroupDiv".freeze

  # DON"T ATTEMPT TO USE THESE ELEMENTS TO SIGN OUT!
  # This is done after every scenario automatically via an 'after' hook.
  # Plus it doesn't seem to work when you use these (see TODO in hooks/after.rb)
  element(:select_profile, "#navTabButtonUserInfoLinkId")
  element(:sign_out, "#navTabButtonUserInfoSignOutId")

end
