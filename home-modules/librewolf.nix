{
  config,
  lib,
  ...
}:
let
  # Extensions force-installed from AMO through enterprise policies.
  # key = extension id, value = AMO slug.
  extensions = {
    "addon@darkreader.org" = "darkreader";
    "saladict@crimx.com" = "ext-saladict";
    "{29f42579-9618-4dc7-8647-eaad7cd3343e}" = "trancyfordesktop";
    "extension@one-tab.com" = "onetab";
    "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = "auto-tab-discard";
  };
in
{
  # LibreWolf 157 stores its profile under the XDG config dir
  # (`~/.config/librewolf/librewolf/`) and loads `librewolf.overrides.cfg`
  # from there, but the Home Manager module writes it to `~/.librewolf/`.
  # Mirror it to the XDG location so the settings actually apply.
  home.file.".config/librewolf/librewolf/librewolf.overrides.cfg".source =
    config.home.file.".librewolf/librewolf.overrides.cfg".source;

  # LibreWolf fixes and additions.
  #
  # LibreWolf ships aggressive defaults: it enables RFP (which forces
  # `prefers-color-scheme: light`, so dark mode cannot work) and clears
  # cookies/storage on shutdown. Both can be adjusted through the
  # `librewolf.overrides.cfg` mechanism that `programs.librewolf.settings`
  # generates (loaded after LibreWolf's own `mozilla.cfg`, so these
  # `defaultPref`s win).
  programs.librewolf = {
    enable = true;

    # Chinese language pack, fetched from Mozilla's release server. The
    # `release` option (defaults to the LibreWolf/Firefox version) decides
    # which langpack version is used.
    languagePacks = [ "zh-CN" ];

    # Extensions installed from AMO. `normal_installed` keeps them updated
    # and present but lets you disable/remove them in about:addons.
    policies.ExtensionSettings =
      {
        # LibreWolf's base policy forbids installing language packs by
        # omitting the `locale` type here, which also makes Firefox uninstall
        # the pack added by `languagePacks` above. Re-allow it.
        "*" = {
          installation_mode = "allowed";
          allowed_types = [
            "dictionary"
            "extension"
            "sitepermission"
            "theme"
            "locale"
          ];
          blocked_install_message = "This extension is managed by your browser policy.";
        };
      }
      // lib.mapAttrs (_id: slug: {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        private_browsing = true;
      }) extensions;

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

      # --- sidebar --------------------------------------------------
      # New sidebar, always visible, on the left, with useful panels.
      "sidebar.revamp" = true;
      "sidebar.visibility" = "always-show";
      "sidebar.position_start" = true;
      "sidebar.main.tools" = "history,bookmarks,syncedtabs";
      "sidebar.verticalTabs" = false;

      # --- Firefox Account / Sync -----------------------------------
      # LibreWolf disables FxA by default; this pref controls the whole
      # feature (including the sign-in UI).
      "identity.fxaccounts.enabled" = true;

      # --- UI language ----------------------------------------------
      "intl.locale.requested" = "zh-CN";
      "intl.accept_languages" = "zh-CN,zh,en-US,en";

      # --- usability -------------------------------------------------
      "webgl.disabled" = false;
    };
  };
}
