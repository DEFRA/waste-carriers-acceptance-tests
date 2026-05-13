# frozen_string_literal: true

# Chrome 147 compatibility patches (project-specific).
# Stale node retries are handled by Quke's env.rb.
#
# 1. JSON viewer: Chrome renders application/json responses with a built-in
#    viewer that does not include <pre> elements. Firefox wraps raw JSON in
#    <pre>. When a "pre" element is not found, this patch injects one via JS.
#
# 2. Notify endpoint timing: Chrome executes clicks faster than Firefox.
#    After a back-office "resend email" action, the Notify API may not have
#    processed the email by the time Chrome visits the endpoint.

return unless Quke::Quke.config.driver == "chrome"

# --- 1. Inject <pre> for Chrome's JSON viewer ---
module ChromeJsonPreInjector
  def find(*args, **kwargs, &)
    super
  rescue Capybara::ElementNotFound
    raise unless args.first.to_s == "pre"

    inject_pre_from_json
    super
  end

  private

  def inject_pre_from_json
    session.execute_script(<<~JS)
      if (!document.querySelector('pre')) {
        var raw = document.body.innerText;
        document.body.innerHTML = '<pre>' + raw.replace(/</g, '&lt;') + '</pre>';
      }
    JS
  end
end

Capybara::Node::Document.prepend(ChromeJsonPreInjector)

# --- 2. Wait before visiting notify endpoints ---
module ChromeNotifyWait # rubocop:disable Style/OneClassPerFile
  def visit(url)
    sleep 1 if url.to_s.include?("notify")
    super
  end
end

Capybara::Session.prepend(ChromeNotifyWait)
