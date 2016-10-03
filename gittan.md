# Gittan


## Agenda

### Basics

* Configure, Local workflow, Data

### Collaboration

* Remotes, Workflows

### Clean Up the Mess

* Undo, Pick, Rewrite, Search


## Disclaimer

### What this class IS?

* Get Git CLI
* Get Git data

### What this class IS NOT?

* GUIs


# Basics

## Configuration

### Get a coloured prompt
### Tell Git who you are

    git config --global user.name 'Valentino Rossi'
    git config --global user.email 'vale@vr46.com'

### Type less

    git config --global alias.lg 'log --decorate --oneline --graph --all'
    git config --global alias.st status

### What is `--global`

* `--global`: user level config in `~/.gitconfig`
* Otherwise repo config is used in `.git/config`

## Browse and Edit

### Git displays big output in the *less* pager

* Quit with `q`
* Search `/<regex>`, next/previous hits `n N`

### Git asks questions by firing up your *favourite editor*

* Which is *vim*, vim, _vim_ or `vim`
* `export EDITOR=emacs`

### Help! `git <command> help` or `git --help <command>`


## Common Problems

### Git is slow!

* No it is not. But store your repo on a local drive. Say no to network drives.

### Certain files are locked

* Do not keep a Git GUI open
* Do not keep working files open in Notepad++ during checkout
