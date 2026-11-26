# Chrome 158 rejects `Storage.clearDataForOrigin` with `origin: "*"`, which
# Capybara 3.40.0 sends at the end of `ChromeDriver#reset!`. Every system test
# then errors in teardown with "invalid argument: * is not a valid URL".
#
# Clear all cookies with `Network.clearBrowserCookies` instead, and clear the
# other storage types only for the app server's origin.
#
# Remove this file when a Capybara release fixes it:
# https://github.com/teamcapybara/capybara/issues/2865
module ClearStorageWithoutWildcardOrigin
  private

  def execute_cdp(cmd, params = {})
    return super unless cmd == "Storage.clearDataForOrigin" && params[:origin] == "*"

    types = params[:storageTypes].to_s.split(",")
    super("Network.clearBrowserCookies") if types.delete("cookies")

    origin = Capybara.current_session.server&.base_url
    super(cmd, params.merge(origin: origin, storageTypes: types.join(","))) if origin && types.any?
  end
end

if Gem.loaded_specs["capybara"].version > Gem::Version.new("3.40.0")
  raise "Capybara was updated: check if #{__FILE__} is still needed (teamcapybara/capybara#2865)"
end

Capybara::Selenium::Driver::ChromeDriver.prepend(ClearStorageWithoutWildcardOrigin)
