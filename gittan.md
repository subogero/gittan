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

    git config --global user.name 'Szabo Gergely'
    git config --global user.email 'szg@subogero.com'

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

    git add motogp
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


## Data - index, HEAD, master

### The index

* Staging area, allows picking changes from worktree to next commit
* Use `git add`, `git rm`, `git mv`

### Refs

* `HEAD`: symbolic ref, points to branch `master`, see `.git/HEAD`
* `master`: branch ref, points to a commit, see `.git/refs/heads/master`
* `19c5f2e`: commit object, identified by SHA1 of its contents

### Continued...


## Branches

### Create and switch to

    git branch hello       # create at HEAD
    git checkout hello     # shwitch to branch, merges worktree and index
    git checkout -b hello  # create and switch to in one step
    git branch old HEAD^   # create at previous commit

### View

    git branch
    git log --oneline --decorate --graph --all
    git lg  # this is an alias

### Delete

    git branch -d old
    git branch -D old  # if points to new commits


## Local branch workflow

### Create commits on branch `hello`

    vi hello        # Add shell script doing Hello World!
    chmod +x hello  # Make it executable
    git add hello
    git commit -m 'Add hello'
    vi motogp       # Add header
    git commit -am 'Add header to motogp'
    git lg

### Fix something on `master` then merge `hello`

    git checkout master
    vi motogp
    git commit -am 'Add Nicky Hayden'
    git lg
    git merge hello
    git lg


## Data - Commit objects

### Refer to commits as SHA1, short SHA1, HEAD, master

    HEAD^     # first parent
    HEAD^^    # first grandparent
    master^2  # second parent if merge commit
    1f2c~2    # grandparent on first parent line
    hello^2~  # grandparent on second parent line

### Commit objects

    git show master
    git cat-file -t master  # object type
    git cat-file -p 2c6d8   # object contents

* Stored in `.git/objects/2c/68d...` as a raw gzip stream, try zpipe
* Commit object refers to parent commits, tree object


## Ignore files

    git checkout -b log
    vi hello  # Create hello.log when run
    ./hello
    git status
    git add hello
    git commit

### We do not care about hello.log, how to ignore

    vi .gitignore  # add hello.log
    git add .gitignore
    git commit -m 'Add .gitignore'

### You can have `.gitignore` files in subdirs too!


## Merge conflicts

### Create the conflict

    vi motogp
    git commit -a
    git checkout master
    vi motogp  # Edit at same location
    git commit -a
    git merge log

### Resolve conflict

    git status     # which files?
    vi motogp      # Remove <<<<<<< ======= >>>>>>> markers, edit
    git commit -a  # Automatically finishes merge commit
