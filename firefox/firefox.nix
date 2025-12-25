{
  config,
  pkgs,
  inputs,
  ...
}:
let
  colors = {
    bg = "#1e1e2e"; # 整体背景
    fg = "#cdd6f4"; # 文字颜色
    accent = "#b4befe"; # 强调色（如地址栏边框）
    urlbg = "#313244"; # 地址栏背景
  };
in
{
  home.file.".mozilla/firefox/default/chrome/wall.png".source = ./wall.png;
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      name = "default";

      extensions.packages =
        let
          addons = inputs.firefox-addons.packages.${pkgs.system};
        in
        [
          addons."vimium-c"
          addons.sidebery
          addons."ublock-origin"
          addons.darkreader
          addons."auto-tab-discard" # 帮你省内存的神器
	  addons.tabliss
        ];

      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browses.newtabpage.activity-stream.baseAssetURL" = "";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "security.fileuri.strict_origin_policy" = false;
        "browser.tabs.drawInTitlebar" = true;
        "dom.ipc.processCount" = 4; # 限制内容进程数
        "browser.sessionstore.interval" = 600000;
        "browser.link.open_newwindow" = 3;
        "browser.link.open_newwindow.restriction" = 0;
        "widget.wayland.opaque-region.enabled" = false;

        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;

        "svg.context-properties.content.enabled" = true;
        "privacy.trackingprotection.enabled" = true;

        # --- 彻底关闭新标签页赞助商内容 ---
        "browser.newtabpage.activity-stream.showSponsored" = false; # 关闭赞助的内容（如 Pocket 推荐）
        "browser.newtabpage.activity-stream.feeds.topsites" = false; # 隐藏那些乱七八糟的快捷方式
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # 关键：关闭截图里那种赞助快捷方式

        # --- 进一步清理新标签页 (可选) ---
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # 关闭 Pocket 推荐文章
        "browser.newtabpage.activity-stream.feeds.snippets" = false; # 关闭火狐官方的小提示
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # 彻底干掉 Pocket

        # --- 隐私与电信数据 (既然你是 NixOS 用户，建议一起关掉) ---
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "toolkit.telemetry.enabled" = false;
      };
      userChrome = ''
        :root {
            --toolbar-bgcolor: ${colors.bg} !important;
            --lwt-accent-color: ${colors.bg} !important;
            --lwt-text-color: ${colors.fg} !important;
            --toolbar-field-background-color: ${colors.urlbg} !important;
            --toolbar-field-focus-background-color: ${colors.urlbg} !important;
            --toolbar-field-border-color: ${colors.accent} !important;
          }
        /* 隐藏顶部标签栏 */
        #TabsToolbar {
          visibility: collapse !important;
        }

        /* 隐藏侧边栏顶部的标题 (Sidebery) */
        #sidebar-header {
          display: none !important;
        }

        /* 极致简约地址栏 */
        #nav-bar {
          margin-top: -5px !important;
          background-color: var(--toolbar-bgcolor) !important;
          box-shadow: none !important;
          border: none !important;
        }

        /* 让地址栏在非聚焦时更透明，很有高级感 */
        #urlbar-background {
          background-color: rgba(30, 30, 30, 0.6) !important;
          border: 1px solid rgba(255, 255, 255, 0.1) !important;
          border-radius: 12px !important;
        }

        /* 移除侧边栏的分隔线 */
        #sidebar-splitter {
          display: none !important;
        }
      '';
    };
  };
}
