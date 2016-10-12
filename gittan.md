% $gittan =~ /suli.subogero.com/
% Szabó Gergely


## Agenda

### Basics

* Configure, Local workflow, Data

### Working Together

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

```bash
git config --global user.name 'Szabo Gergely'
git config --global user.email 'szg@subogero.com'
```

### Type less

```bash
git config --global alias.lg 'log --decorate --oneline --graph --all'
git config --global alias.st status
```

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

```bash
mkdir gittan
cd gittan
vi motogp
```

### Add repo later

```bash
git init
git add motogp
git commit
```


## Looking and staging

### State before and after edit

```bash
git status
vi motogp
git status
```

### State after staging. Spot the difference

```bash
git add motogp
git status
git commit -m 'commit message'
```

### Implicit staging

```bash
vi motogp
git commit -a
```


## Changes in detail

### Unstaged AND staged changes, a.k.a the index

```bash
vi motogp
git add motogp
vi motogp
git status
```

### Diffs

```bash
git diff                   # worktree vs index
git diff HEAD        # worktree vs last commit
git diff --cached HEAD  # index vs last commit
git diff HEAD^ HEAD        # compare 2 commits
```


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

```bash
git branch hello                             # create at HEAD
git checkout hello  # shwitch to branch, merge worktree/index
git checkout -b hello      # create and switch to in one step
git branch old HEAD^              # create at previous commit
```

### View

```bash
git branch
git log --oneline --decorate --graph --all
git lg  # this is an alias
```

### Delete

```bash
git branch -d old
git branch -D old  # if points to new commits
```


## Local branch workflow

### Create commits on branch `hello`

```bash
vi hello   # Add shell script doing Hello World!
chmod +x hello              # Make it executable
git add hello
git commit -m 'Add hello'
vi motogp                           # Add header
git commit -am 'Add header to motogp'
git lg
```

### Fix something on `master` then merge `hello`

```bash
git checkout master
vi motogp
git commit -am 'Add Nicky Hayden'
git lg
git merge hello
git lg
```


## Data - Commit objects

### Refer to commits as SHA1, short SHA1, HEAD, master

```bash
HEAD^                          # first parent
HEAD^^                    # first grandparent
master^2      # second parent if merge commit
1f2c~2     # grandparent on first parent line
hello^2~  # grandparent on second parent line
```

### Commit objects

```bash
git show master
git cat-file -t master      # object type
git cat-file -p 2c6d8   # object contents
```

* Stored in `.git/objects/2c/68d...` as a raw gzip stream, try zpipe
* Commit object refers to parent commits, tree object


## Ignore files

```bash
git checkout -b log
vi hello  # Create hello.log when run
./hello
git status
git add hello
git commit
```

### We do not care about hello.log, how to ignore

```bash
vi .gitignore  # add hello.log
git add .gitignore
git commit -m 'Add .gitignore'
```

### You can have `.gitignore` files in subdirs too!


## Merge conflicts

### Create the conflict

```bash
vi motogp
git commit -a
git checkout master
vi motogp            # Edit at same location
git commit -a
git merge log
```

### Resolve conflict

```bash
git status                                  # which files?
vi motogp   # Remove <<<<<<< ======= >>>>>>> markers, edit
git commit -a        # Automatically finishes merge commit
```


# Working Together


## Client-Server systems are BAD

### Everything goes over the network

* Slow
* No infra, no life. No offline work

### The paradox and the Politics

* Only tested, reviewed stuff should be checked in
* How do you know what you have tested and reviewd before checkin?
* Every checkin is immediately public and offical. So who has commit access?


## Distributed systems are GOOD

### Nearly everything is local

* Fast
* Start project locally, work offline

### Paradox and Politics? Solved

* Commit in private repo
* Publish into you your public repo
* Becomes official by merging into third repo


## Distributed systems are BAD. Really?

### Every clone of a project contains the entire history

* Not as large as you think

### Chaos! Where is the official repo?

* Technically, there is none
* But in fact, you can build a far superior scalable centralised system


## Git is distributed

### Remotes

* Aliases to URLs of other known repos
* Standard protocols used, mostly HTTP and SSH
* Clone: default remote is called `origin`

### Immutable data model

* Commits do not change existing data, only add new
* Very easy to transfer new data between remotes


## Create your Public Repo In the Cloud

### Get account on Github, Stash, etc

* Create account

### Set up new repo on the UI

* Create empty repo `gittan`
* Copy its Clone URL to clipboard (SSH preferred)

## Or Use Account on suli.subogero.com

### Passwordless public-key SSH login

```bash
ssh-keygen
ssh suli.subogero.com 'cat >>.ssh/authorized_keys' <.ssh/id_rsa.pub
```

### Create repo

```bash
ssh suli.subogero.com
mkdir gittan.git && cd gittan.git
git init --bare                       # Server repo, no worktree
mv hooks/post-update.sample hooks/post-update  # for HTTP clones
```

### Copy its URL

```bash
suli.subogero.com:gittan.git   # URL in SCP format for SSH
```
