{
  ...
}:
{
  # LibreWolf fixes.
  #
  # LibreWolf ships aggressive defaults: it enables RFP (which forces
  # `prefers-color-scheme: light`, so dark mode cannot work) and clears
  # cookies/storage on shutdown. Both can be adjusted through the
  # `librewolf.overrides.cfg` mechanism that `programs.librewolf.settings`
  # generates (loaded after LibreWolf's own `mozilla.cfg`, so these
  # `defaultPref`s win).
  programs.librewolf = {
    enable = true;
    settings = {
      # --- keep cookies / history across restarts -------------------
      "privacy.sanitize.sanitizeOnShutdown" = false;
      # Firefox 128+ moved the "Clear on shutdown" options to _v2 prefs;
      # LibreWolf sets `privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3`,
      # which makes the old `privacy.clearOnShutdown.*` prefs ineffective.
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
      "privacy.clearOnShutdown_v2.formdata" = false;
      "privacy.clearOnShutdown_v2.siteSettings" = false;
      # Legacy prefs, kept for older LibreWolf/Firefox builds.
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "privacy.clearOnShutdown.offlineApps" = false;
      "network.cookie.lifetimePolicy" = 0;

      # --- dark mode ------------------------------------------------
      # RFP is what pins the content color scheme to light.
      "privacy.resistFingerprinting" = false;
      "privacy.resistFingerprinting.pbmode" = false;
      # Force the browser chrome + website appearance to dark.
      # `browser.theme.*-theme`: 0 = dark, 1 = light, 2 = system.
      "ui.systemUsesDarkTheme" = 1;
      "browser.theme.toolbar-theme" = 0;
      "browser.theme.content-theme" = 0;
      # `layout.css.prefers-color-scheme.content-override`: 0 = dark.
      "layout.css.prefers-color-scheme.content-override" = 0;

      # --- usability -------------------------------------------------
      "webgl.disabled" = false;
    };
  };
}
