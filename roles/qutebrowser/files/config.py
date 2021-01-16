c.url.searchengines = {
    'DEFAULT': 'https://cn.bing.com/search?q={}',
    'google': 'https://www.google.com/search?hl=en&q={}',
    'ws': 'https://wiki.archlinux.org/?search={}',
    'baidu': 'https://www.baidu.com/s?wd={}',
    'github': 'https://github.com/search?q={}&ref=opensearch'
}

# Automatically enter insert mode if an editable element is focused
# after loading the page.
# c.input.insert_mode.auto_load = True
config.bind('<Ctrl-H>', 'open-editor', mode='insert')

c.auto_save.session = True
c.editor.command = ['termite', '--name=floatingApp', '-e', "vim -f {file} -c 'normal {line}G{column0}l'"]

# readline insert mode, ref: https://github.com/qutebrowser/qutebrowser/issues/5854

c.bindings.commands = {
    'insert': {
        '<Ctrl-f>'        : 'fake-key <Right>',
        '<Ctrl-b>'        : 'fake-key <Left>',
        '<Ctrl-a>'        : 'fake-key <Home>',
        '<Ctrl-e>'        : 'fake-key <End>',
        '<Ctrl-n>'        : 'fake-key <Down>',
        '<Ctrl-p>'        : 'fake-key <Up>',
        '<Alt-v>'         : 'fake-key <PgUp>',
        '<Ctrl-v>'        : 'fake-key <PgDown>',
        '<Alt-f>'         : 'fake-key <Ctrl-Right>',
        '<Alt-b>'         : 'fake-key <Ctrl-Left>',
        '<Ctrl-d>'        : 'fake-key <Delete>',
        '<Alt-d>'         : 'fake-key <Ctrl-Delete>',
        '<Alt-Backspace>': 'fake-key <Ctrl-Backspace>',
        '<Ctrl-y>': 'insert-text {primary}',
        '<Ctrl-h>': 'open-editor',
    },
}

config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('x', 'tab-close')
config.bind('X', 'undo')

c.url.start_pages = ['https://cn.bing.com']
