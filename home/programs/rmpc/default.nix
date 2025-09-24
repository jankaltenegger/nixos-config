{
  programs.rmpc = {
    enable = true;
    config = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          address: "127.0.0.1:6600",
          password: None,
          theme: "nord",
          cache_dir: None,
          on_song_change: None,
          volume_step: 5,
          max_fps: 30,
          scrolloff: 0,
          wrap_navigation: false,
          enable_mouse: true,
          status_update_interval_ms: 1000,
          select_current_song_on_change: false,
          album_art: (
              method: Auto,
              max_size_px: (width: 1200, height: 1200),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
          ),
          keybinds: (
              global: {
                  ":":       CommandMode,
                  ",":       VolumeDown,
                  "s":       Stop,
                  ".":       VolumeUp,
                  "<Tab>":   NextTab,
                  "<S-Tab>": PreviousTab,
                  "1":       SwitchToTab("Queue"),
                  "2":       SwitchToTab("Directories"),
                  "3":       SwitchToTab("Artists"),
                  "4":       SwitchToTab("Album Artists"),
                  "5":       SwitchToTab("Albums"),
                  "6":       SwitchToTab("Playlists"),
                  "7":       SwitchToTab("Search"),
                  "q":       Quit,
                  ">":       NextTrack,
                  "p":       TogglePause,
                  "<":       PreviousTrack,
                  "f":       SeekForward,
                  "z":       ToggleRepeat,
                  "x":       ToggleRandom,
                  "c":       ToggleConsume,
                  "v":       ToggleSingle,
                  "b":       SeekBack,
                  "~":       ShowHelp,
                  "I":       ShowCurrentSongInfo,
                  "O":       ShowOutputs,
                  "P":       ShowDecoders,
              },
              navigation: {
                  "k":         Up,
                  "j":         Down,
                  "h":         Left,
                  "l":         Right,
                  "<Up>":      Up,
                  "<Down>":    Down,
                  "<Left>":    Left,
                  "<Right>":   Right,
                  "<C-k>":     PaneUp,
                  "<C-j>":     PaneDown,
                  "<C-h>":     PaneLeft,
                  "<C-l>":     PaneRight,
                  "<C-u>":     UpHalf,
                  "N":         PreviousResult,
                  "a":         Add,
                  "A":         AddAll,
                  "r":         Rename,
                  "n":         NextResult,
                  "g":         Top,
                  "<Space>":   Select,
                  "<C-Space>": InvertSelection,
                  "G":         Bottom,
                  "<CR>":      Confirm,
                  "i":         FocusInput,
                  "J":         MoveDown,
                  "<C-d>":     DownHalf,
                  "/":         EnterSearch,
                  "<C-c>":     Close,
                  "<Esc>":     Close,
                  "K":         MoveUp,
                  "D":         Delete,
              },
              queue: {
                  "D":       DeleteAll,
                  "<CR>":    Play,
                  "<C-s>":   Save,
                  "a":       AddToPlaylist,
                  "d":       Delete,
                  "i":       ShowInfo,
                  "C":       JumpToCurrent,
              },
          ),
          search: (
              case_sensitive: false,
              mode: Contains,
              tags: [
                  (value: "any",         label: "Any Tag"),
                  (value: "artist",      label: "Artist"),
                  (value: "album",       label: "Album"),
                  (value: "albumartist", label: "Album Artist"),
                  (value: "title",       label: "Title"),
                  (value: "filename",    label: "Filename"),
                  (value: "genre",       label: "Genre"),
              ],
          ),
          artists: (
              album_display_mode: SplitByDate,
              album_sort_by: Date,
          ),
        tabs: [

            (

                name: "Queue",

                pane: Split(

                    direction: Vertical,

                    panes: [

                        (

                            size: "100%",

                            borders: "NONE",

                            pane: Split(

                                borders: "NONE",

                                direction: Horizontal,

                                panes: [

                                    (

                                        size: "70%",

                                        borders: "ALL",

                                        pane: Pane(Queue),

                                    ),

                                    (

                                        size: "30%",

                                        borders: "NONE",

                                        pane: Split(

                                            direction: Vertical,

                                            panes: [

                                                (

                                                    size: "75%",

                                                    borders: "ALL",

                                                    pane: Pane(AlbumArt),

                                                ),

                                                (

                                                    size: "25%",

                                                    borders: "NONE",

                                                    pane: Split(

                                                        direction: Vertical,

                                                        panes: [

                                                            (

                                                                size: "100%",

                                                                pane: Pane(Lyrics),

                                                            ),

                                                        ]

                                                    ),

                                                ),

                                            ]

                                        ),

                                    ),

                                ]

                            ),

                        ),

                    ],

                ),

            ),

            (

                name: "Directories",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Directories))],

                ),

            ),

            (

                name: "Artists",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Artists))],

                ),

            ),

            (

                name: "Album Artists",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(AlbumArtists))],

                ),

            ),

            (

                name: "Albums",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Albums))],

                ),

            ),

            (

                name: "Playlists",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Playlists))],

                ),

            ),

            (

                name: "Search",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Search))],

                ),

            ),

            (

                name: "Browser",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Browser(root_tag: "Artist")))],

                ),

            ),

            (

                name: "Lyrics",

                pane: Split(

                    direction: Horizontal,

                    panes: [(size: "100%", borders: "ALL", pane: Pane(Lyrics))],

                ),

            ),

        ],
      )
    '';
  };

  xdg.configFile."rmpc/nord.ron".text = ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]
    (
        default_album_art_path: None,
        show_song_table_header: true,
        draw_borders: true,
        browser_column_widths: [20, 38, 42],
        background_color: "#2e3440",
        modal_backdrop: true,
        text_color: "#d8dee9",
        header_background_color: "#2e3440",
        modal_background_color: "#2e3440",
        preview_label_style: (fg: "#b48ead"),
        preview_metadata_group_style: (fg: "#88c0d0"),
        tab_bar: (
            enabled: true,
            active_style: (fg: "#2e3440", bg: "#81A1C1", modifiers: "Bold"),
            inactive_style: (fg: "#d8dee9", bg: "#2e3440", modifiers: ""),
        ),
        highlighted_item_style: (fg: "#a3be8c", modifiers: "Bold"),
        current_item_style: (fg: "#2e3440", bg: "#81a1c1", modifiers: "Bold"),
        borders_style: (fg: "#81a1c1", modifiers: "Bold"),
        highlight_border_style: (fg: "#81a1c1"),
        symbols: (song: "󰝚 ", dir: " ", marker: "* ", ellipsis: "..."),
        progress_bar: (
            symbols: ["█", "█", "█", "█", "█"],
            track_style: (fg: "#3b4252"),
            elapsed_style: (fg: "#81a1c1"),
            thumb_style: (fg: "#81a1c1"),
        ),
        scrollbar: (
            symbols: ["│", "█", "▲", "▼"],
            track_style: (fg: "#81a1c1"),
            ends_style: (fg: "#81a1c1"),
            thumb_style: (fg: "#81a1c1"),
        ),
        song_table_format: [
            (
                prop: (kind: property(artist), style: (fg: "#81a1c1"),
                    default: (kind: text("unknown"), style: (fg: "#b48ead"))
                ),
                width: "20%",
            ),
            (
                prop: (kind: property(title), style: (fg: "#88c0d0"),
                    highlighted_item_style: (fg: "#d8dee9", modifiers: "bold"),
                    default: (kind: property(filename), style: (fg: "#d8dee9"),)
                ),
                width: "35%",
            ),
            (
                prop: (kind: property(album), style: (fg: "#81a1c1"),
                    default: (kind: text("unknown album"), style: (fg: "#b48ead"))
                ),
                width: "30%",
            ),
            (
                prop: (kind: property(duration), style: (fg: "#88c0d0"),
                    default: (kind: text("-"))
                ),
                width: "15%",
                alignment: right,
            ),
        ],
        layout: split(
            direction: vertical,
            panes: [
                (
                    size: "3",
                    pane: pane(tabs),
                ),
                (
                    size: "4",
                    pane: split(
                        direction: horizontal,
                        panes: [
                            (
                                size: "100%",
                                pane: split(
                                    direction: vertical,
                                    panes: [
                                        (
                                            size: "4",
                                            borders: "all",
                                            pane: pane(header),
                                        ),
                                    ]
                                )
                            ),
                        ]
                    ),
                ),
                (
                    size: "100%",
                    pane: split(
                        direction: horizontal,
                        panes: [
                            (
                                size: "100%",
                                borders: "none",
                                pane: pane(tabcontent),
                            ),
                        ]
                    ),
                ),
                (
                    size: "3",
                    borders: "top | bottom",
                    pane: pane(progressbar),
                ),
            ],
        ),
        header: (
            rows: [
                (
                    left: [
                        (kind: text(""), style: (fg: "#81a1c1", modifiers: "bold")),
                        (kind: property(status(statev2(playing_label: "  ", paused_label: "  ", stopped_label: "  ")))),
                        (kind: text(" "), style: (fg: "#81a1c1", modifiers: "bold")),
                        (kind: property(widget(scanstatus)))

                    ],
                    center: [
                        (kind: property(song(title)), style: (fg: "#d8dee9",modifiers: "bold"),
                            default: (kind: property(song(filename)), style: (fg: "#d8dee9",modifiers: "bold"))
                        )
                    ],
                    right: [
                        (kind: text("󱡬"), style: (fg: "#81a1c1", modifiers: "bold")),
                        (kind: property(status(volume)), style: (fg: "#d8dee9", modifiers: "bold")),
                        (kind: text("%"), style: (fg: "#81a1c1", modifiers: "bold"))
                    ]
                ),
                (
                    left: [
                        (kind: text("[ "),style: (fg: "#81a1c1", modifiers: "bold")),
                        (kind: property(status(elapsed)),style: (fg: "#d8dee9")),
                        (kind: text(" / "),style: (fg: "#81a1c1", modifiers: "bold")),
                        (kind: property(status(duration)),style: (fg: "#d8dee9")),
                        (kind: text(" | "),style: (fg: "#81a1c1")),
                        (kind: property(status(bitrate)),style: (fg: "#d8dee9")),
                        (kind: text(" kbps"),style: (fg: "#81a1c1")),
                        (kind: text("]"),style: (fg: "#81a1c1", modifiers: "bold"))
                    ],
                    center: [
                        (kind: property(song(artist)), style: (fg: "#88c0d0", modifiers: "bold"),
                            default: (kind: text("unknown artist"), style: (fg: "#88c0d0", modifiers: "bold"))
                        ),
                        (kind: text(" - ")),
                        (kind: property(song(album)),style: (fg: "#81a1c1" ),
                            default: (kind: text("unknown album"), style: (fg: "#81a1c1", modifiers: "bold"))
                        )
                    ],
                    right: [
                        (kind: text("[ "),style: (fg: "#81a1c1")),
                        (kind: property(status(repeatv2(
                                        on_label: "", off_label: "",
                                        on_style: (fg: "#d8dee9", modifiers: "bold"), off_style: (fg: "#4c566a", modifiers: "bold"))))),
                        (kind: text(" | "),style: (fg: "#81a1c1")),
                        (kind: property(status(randomv2(
                                        on_label: "", off_label: "",
                                        on_style: (fg: "#d8dee9", modifiers: "bold"), off_style: (fg: "#4c566a", modifiers: "bold"))))),
                        (kind: text(" | "),style: (fg: "#81a1c1")),
                        (kind: property(status(consumev2(
                                        on_label: "󰮯", off_label: "󰮯", oneshot_label: "󰮯󰇊",
                                        on_style: (fg: "#d8dee9", modifiers: "bold"), off_style: (fg: "#4c566a", modifiers: "bold"))))),
                        (kind: text(" | "),style: (fg: "#81a1c1")),
                        (kind: property(status(singlev2(
                                        on_label: "󰎤", off_label: "󰎦", oneshot_label: "󰇊", off_oneshot_label: "󱅊",
                                        on_style: (fg: "#d8dee9", modifiers: "bold"), off_style: (fg: "#4c566a", modifiers: "bold"))))),
                        (kind: text(" ]"),style: (fg: "#81a1c1")),
                    ]
                ),
            ],
        ),
        browser_song_format: [
            (
                kind: group([
                        (kind: property(track)),
                        (kind: text(" ")),
                    ])
            ),
            (
                kind: group([
                        (kind: property(artist)),
                        (kind: text(" - ")),
                        (kind: property(title)),
                    ]),
                default: (kind: property(filename))
            ),
        ],
    )
  '';
}
