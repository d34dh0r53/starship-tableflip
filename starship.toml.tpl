"$schema" = 'https://starship.rs/config-schema.json'
add_newline = false

format = """
[╭](blue)\
[](blue)\
[  ](bg:blue fg:white)\
[](bg:surface0 fg:blue)\
$directory\
[](fg:surface0 bg:mantle)\
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
[](mantle)\
\n$character"""

palette = 'omarchy'

continuation_prompt = '☞ '

[directory]
style = "fg:blue bg:surface0"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol $branch ](fg:peach bg:mantle)]($style)'

[git_status]
style = "fg:overlay2 bg:mantle"
up_to_date = '[✓](fg:green bg:mantle)'
diverged   = '[[[[󱡷 ](fg:sapphire bg:mantle)$ahead_count](fg:green bg:mantle)󰇙](fg:sapphire bg:mantle)$behind_count](fg:maroon bg:mantle)'
conflicted = '[[⋮](fg:sapphire bg:mantle) \($count\)](fg:maroon bg:mantle)'
ahead      = '[[⋮](fg:sapphire bg:mantle) \($count\)](fg:peach bg:mantle)'
behind     = '[[⋮](fg:sapphire bg:mantle)󰍷 \($count\)](fg:peach bg:mantle)'
stashed    = '[[⋮](fg:sapphire bg:mantle)󱥦 \($count\)](fg:peach bg:mantle)'
renamed    = '[[⋮](fg:sapphire bg:mantle) \($count\)](fg:peach bg:mantle)'
untracked  = '[[⋮](fg:sapphire bg:mantle)󱔢 \($count\)](fg:pink bg:mantle)'
modified   = '[[⋮](fg:sapphire bg:mantle)󰲶 \($count\)](fg:peach bg:mantle)'
staged     = '[[⋮](fg:sapphire bg:mantle) \($count\)](fg:green bg:mantle)'
deleted    = '[[⋮](fg:sapphire bg:mantle) \($count\)](fg:red bg:mantle)'
format = '[[($all_status$ahead_behind )](fg:sapphire bg:mantle)]($style)'

[git_commit]
style = "fg:overlay2 bg:mantle"
tag_disabled = false
tag_symbol = '  '
format = '[[\($hash$tag\) ](fg:peach bg:mantle)]($style)'

[nodejs]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($version) ](fg:lavender bg:mantle)]($style)'

[rust]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($version) ](fg:lavender bg:mantle)]($style)'

[golang]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($version) ](fg:lavender bg:mantle)]($style)'

[php]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($version) ](fg:lavender bg:mantle)]($style)'

[python]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($version) ](fg:lavender bg:mantle)]($style)'

[openstack]
symbol = ""
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($cloud) ](fg:mauve bg:mantle)]($style)'

[kubernetes]
symbol = "☸"
style = "fg:overlay2 bg:mantle"
format = '[[ $symbol ($context) ](fg:mauve bg:mantle)]($style)'

[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "fg:overlay2 bg:mantle"
format = '[[  $time ](fg:sky bg:mantle)]($style)'

[character]
success_symbol            = '[╰☞° ͜ °☞](blue)'
error_symbol              = "[╰╯°□°╯︵┻━┻](red)"
vimcmd_symbol             = "[╰ง ͠° ͜ʖ ͡°ง](peach)"
vimcmd_replace_one_symbol = "[╰ง ͠° ͜ʖ ͡°ง](pink)"
vimcmd_replace_symbol     = "[╰ง ͠° ͜ʖ ͡°ง](yellow)"
vimcmd_visual_symbol      = "[╰ง ͠° ͜ʖ ͡°ง](green)"

[battery]
disabled = true

# [directory]
# truncation_length = 100
#
# Rendered by Omarchy (omarchy theme set) from the current theme's
# colors.toml. This file is a template: symlink it into
# ~/.config/omarchy/themed/starship.toml.tpl and point ~/.config/starship.toml
# at ~/.local/state/omarchy/current/theme/starship.toml.
[palettes.omarchy]
# Status colors
red = "{{ red }}"
maroon = "{{ bright_red }}"
green = "{{ green }}"
yellow = "{{ yellow }}"
peach = "{{ orange }}"
pink = "{{ bright_magenta }}"

# Accents
blue = "{{ accent }}"
white = "{{ bright_foreground }}"
lavender = "{{ bright_blue }}"
sapphire = "{{ bright_blue }}"
mauve = "{{ purple }}"
sky = "{{ cyan }}"
teal = "{{ bright_cyan }}"

# Foregrounds / surfaces
text = "{{ foreground }}"
overlay2 = "{{ muted }}"
surface0 = "{{ lighter_background }}"
base = "{{ background }}"
mantle = "{{ dark_background }}"
crust = "{{ darker_background }}"
