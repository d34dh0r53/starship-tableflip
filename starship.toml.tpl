"$schema" = 'https://starship.rs/config-schema.json'
add_newline = false

format = """
[╭](accent)\
[](accent)\
[  ](bg:accent fg:bright_foreground)\
[](bg:lighter_background fg:accent)\
$directory\
[](fg:lighter_background bg:dark_background)\
$git_branch\
$git_commit\
$git_status\
$nodejs\
$rust\
$golang\
$php\
$python\
$openstack\
$kubernetes\
$time\
[](dark_background)\
\n$character"""

palette = 'omarchy'

continuation_prompt = '☞ '

[directory]
style = "fg:accent bg:lighter_background"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol $branch ](fg:orange bg:dark_background)]($style)'

[git_status]
style = "fg:muted bg:dark_background"
up_to_date = '[✓](fg:green bg:dark_background)'
diverged   = '[[[[󱡷 ](fg:bright_blue bg:dark_background)$ahead_count](fg:green bg:dark_background)󰇙](fg:bright_blue bg:dark_background)$behind_count](fg:bright_red bg:dark_background)'
conflicted = '[[⋮](fg:bright_blue bg:dark_background) \($count\)](fg:bright_red bg:dark_background)'
ahead      = '[[⋮](fg:bright_blue bg:dark_background) \($count\)](fg:orange bg:dark_background)'
behind     = '[[⋮](fg:bright_blue bg:dark_background)󰍷 \($count\)](fg:orange bg:dark_background)'
stashed    = '[[⋮](fg:bright_blue bg:dark_background)󱥦 \($count\)](fg:orange bg:dark_background)'
renamed    = '[[⋮](fg:bright_blue bg:dark_background) \($count\)](fg:orange bg:dark_background)'
untracked  = '[[⋮](fg:bright_blue bg:dark_background)󱔢 \($count\)](fg:bright_magenta bg:dark_background)'
modified   = '[[⋮](fg:bright_blue bg:dark_background)󰲶 \($count\)](fg:orange bg:dark_background)'
staged     = '[[⋮](fg:bright_blue bg:dark_background) \($count\)](fg:green bg:dark_background)'
deleted    = '[[⋮](fg:bright_blue bg:dark_background) \($count\)](fg:red bg:dark_background)'
format = '[[($all_status$ahead_behind )](fg:bright_blue bg:dark_background)]($style)'

[git_commit]
style = "fg:muted bg:dark_background"
tag_disabled = false
tag_symbol = '  '
format = '[[\($hash$tag\) ](fg:orange bg:dark_background)]($style)'

[nodejs]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($version) ](fg:bright_blue bg:dark_background)]($style)'

[rust]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($version) ](fg:bright_blue bg:dark_background)]($style)'

[golang]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($version) ](fg:bright_blue bg:dark_background)]($style)'

[php]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($version) ](fg:bright_blue bg:dark_background)]($style)'

[python]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($version) ](fg:bright_blue bg:dark_background)]($style)'

[openstack]
symbol = ""
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($cloud) ](fg:purple bg:dark_background)]($style)'

[kubernetes]
symbol = "☸"
style = "fg:muted bg:dark_background"
format = '[[ $symbol ($context) ](fg:purple bg:dark_background)]($style)'

[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "fg:muted bg:dark_background"
format = '[[  $time ](fg:cyan bg:dark_background)]($style)'

[character]
success_symbol            = '[╰☞° ͜ °☞](accent)'
error_symbol              = "[╰╯°□°╯︵┻━┻](red)"
vimcmd_symbol             = "[╰ง ͠° ͜ʖ ͡°ง](orange)"
vimcmd_replace_one_symbol = "[╰ง ͠° ͜ʖ ͡°ง](bright_magenta)"
vimcmd_replace_symbol     = "[╰ง ͠° ͜ʖ ͡°ง](yellow)"
vimcmd_visual_symbol      = "[╰ง ͠° ͜ʖ ͡°ง](green)"

[battery]
disabled = true

# Generic Omarchy palette. install.sh drops this template into
# ~/.config/omarchy/themed/; every `omarchy theme set` renders the palette
# from the active theme's colors.toml into
# ~/.local/state/omarchy/current/theme/starship.toml.
[palettes.omarchy]
# Status colors
red = "{{ red }}"
bright_red = "{{ bright_red }}"
green = "{{ green }}"
yellow = "{{ yellow }}"
orange = "{{ orange }}"
bright_magenta = "{{ bright_magenta }}"

# Accents
accent = "{{ accent }}"
bright_foreground = "{{ bright_foreground }}"
bright_blue = "{{ bright_blue }}"
purple = "{{ purple }}"
cyan = "{{ cyan }}"

# Foregrounds / surfaces
foreground = "{{ foreground }}"
muted = "{{ muted }}"
lighter_background = "{{ lighter_background }}"
background = "{{ background }}"
dark_background = "{{ dark_background }}"
darker_background = "{{ darker_background }}"
