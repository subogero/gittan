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

* Git CLI
* Git data

### What this class IS NOT?

* Git GUIs


# Basics

## Configuration

### Get a coloured prompt
### Tell Git who you are

    git config --global user.name 'Valentino Rossi'
    git config --global user.email 'vale@vr46.it'

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

* Git GUIs lock some files in .git, close them!
* Checkout fails: close working files in your Windows editor


## Let us start

### Create project

    mkdir gittan
    cd gittan
    vi motogp

### Add repo later

    git init
    git add motogp
    git commit


## Looking and staging

### State before and after edit

    git status
    vi motogp
    git status

### State after staging. Spot the difference

    git add rider
    git status
    git commit -m 'commit message'

### Implicit staging

    vi motogp
    git commit -a


## Changes in detail

### Unstaged AND staged changes, a.k.a the index

    vi motogp
    git add motogp
    vi motogp
    git status

### Diffs

    git diff                # worktree vs index
    git diff HEAD           # worktree vs last commit
    git diff --cached HEAD  # index vs last commit
    git diff HEAD^ HEAD     # compare 2 commits
