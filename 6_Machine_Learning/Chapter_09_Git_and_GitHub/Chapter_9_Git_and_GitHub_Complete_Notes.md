# Chapter 9: Git and GitHub --- Complete Notes

## 1. What Is Version Control?

**Version control** is a system that records changes to files over time.
It helps you track what changed, maintain versions of a project, and
restore earlier work when needed.

## 2. What Is Git?

**Git** is a distributed version control system. It tracks changes in a
repository and stores commits in the local repository on your computer.
Many Git operations work offline.

## 3. What Is GitHub?

**GitHub** is an online platform for hosting Git repositories and
collaborating with other developers. It lets teams share code, review
proposed changes, discuss work, and manage projects.

Think of GitHub as an online place to host and collaborate on Git
projects.

## 4. Git vs. GitHub

  -----------------------------------------------------------------------
  Feature                 Git                     GitHub
  ----------------------- ----------------------- -----------------------
  Type                    Version control system  Online repository
                                                  hosting and
                                                  collaboration platform

  Main purpose            Track code changes and  Host, share, and
                          history                 collaborate on
                                                  repositories

  Where it works          Primarily on your       Online
                          computer; can also work 
                          with remote             
                          repositories            

  Internet required?      Not for most local      Usually required to
                          operations              access or sync with
                                                  hosted repositories

  Example                 `git commit` saves a    `git push` sends
                          snapshot locally        commits to GitHub
  -----------------------------------------------------------------------

## 5. Important Git Concepts

  -----------------------------------------------------------------------
  Term                                Meaning
  ----------------------------------- -----------------------------------
  Repository (repo)                   A project whose files and change
                                      history Git tracks

  Working directory                   The files you are currently editing

  Staging area                        The proposed set of changes for the
                                      next commit

  Commit                              A saved snapshot of staged changes

  Branch                              A separate line of development

  Merge                               Combines changes from one branch
                                      into another

  Remote                              A named connection to another
                                      repository, often hosted on GitHub

  Push                                Sends local commits to a remote
                                      repository

  Fetch                               Downloads remote updates without
                                      integrating them into your current
                                      branch

  Pull                                Fetches remote updates and
                                      integrates them into the current
                                      branch

  Clone                               Creates a local copy of an existing
                                      repository

  Pull Request (PR)                   A GitHub proposal to review and
                                      merge changes from one branch into
                                      another

  Code review                         Reviewing proposed code changes for
                                      correctness, quality, and
                                      maintainability
  -----------------------------------------------------------------------

## 6. How Git Tracks Changes

A simplified workflow is:

1.  **Working directory:** Create or edit files.
2.  **Staging area:** Select the changes you want to include in the next
    commit.
3.  **Local repository:** Commit the staged changes.
4.  **Remote repository:** Push commits to GitHub to share them.

``` text
Edit files → Stage changes → Commit locally → Push to GitHub
```

Git can track changes locally without an internet connection. Internet
access is generally needed to sync with GitHub.

## 7. Common Git Commands

### A. Configure Git

Set the name and email that Git records in your commits:

``` bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Check the configuration:

``` bash
git config --global --list
git config user.name
git config user.email
```

Use the email associated with your GitHub account if you want your
commits to be associated with that account. Do not put passwords or
access tokens in Git configuration commands.

### B. Create or Copy a Repository

  -----------------------------------------------------------------------
  Task                                Command
  ----------------------------------- -----------------------------------
  Initialize a repository in the      `git init`
  current folder                      

  Copy an existing remote repository  `git clone <repository-url>`
  locally                             

  Display the current repository root `git rev-parse --show-toplevel`
  -----------------------------------------------------------------------

Example:

``` bash
git init
```

Run `git init` inside the project folder you want Git to track.

### C. Check Status and Inspect Changes

  Task                                        Command
  ------------------------------------------- ---------------------
  Show changed, staged, and untracked files   `git status`
  Show unstaged changes                       `git diff`
  Show staged changes                         `git diff --staged`
  Show commit history                         `git log`
  Show concise commit history                 `git log --oneline`
  Show details of a commit or object          `git show`

Use `git status` frequently to understand the state of your files.

### D. Stage Changes

  -----------------------------------------------------------------------
  Task                                Command
  ----------------------------------- -----------------------------------
  Stage one file                      `git add <file>`

  Stage all changes under the current `git add .`
  directory                           

  Stage all tracked modifications and `git add -u`
  deletions                           

  Unstage a file while keeping its    `git restore --staged <file>`
  edits                               
  -----------------------------------------------------------------------

`git add .` stages new, modified, and deleted files under the current
directory, subject to Git's ignore rules. Review `git status` before
committing.

### E. Commit Changes

  ----------------------------------------------------------------------------
  Task                                Command
  ----------------------------------- ----------------------------------------
  Commit staged changes and open the  `git commit`
  configured editor                   

  Commit staged changes with a        `git commit -m "Describe the change"`
  message                             

  Stage tracked modifications and     `git commit -am "Describe the change"`
  commit them in one step             

  Amend the latest commit             `git commit --amend`
  ----------------------------------------------------------------------------

**Important:** `git commit -am` does not include new, untracked files.
Stage new files with `git add` first. Amending changes an existing
commit; be careful when the commit has already been shared with others.

### F. Undo or Discard Changes Carefully

  -----------------------------------------------------------------------
  Task                                Command
  ----------------------------------- -----------------------------------
  Unstage a staged file and keep its  `git restore --staged <file>`
  working-file edits                  

  Discard unstaged edits to a file    `git restore <file>`

  Unstage all staged changes using    `git reset`
  the reset form                      

  Unstage one file using the reset    `git reset <file>`
  form                                

  Create a new commit that reverses   `git revert <commit-id>`
  an earlier commit                   
  -----------------------------------------------------------------------

**Caution:** `git restore <file>` discards uncommitted edits in that
file. `git reset --hard` can permanently discard local changes; do not
use it unless you understand exactly what will be removed. Prefer
`git revert` when undoing a commit that has already been shared.

### G. Branching and Merging

  Task                                      Command
  ----------------------------------------- -------------------------------
  List local branches                       `git branch`
  List local and remote-tracking branches   `git branch -a`
  Create a branch                           `git branch <branch-name>`
  Switch to an existing branch              `git switch <branch-name>`
  Create and switch to a new branch         `git switch -c <branch-name>`
  Merge a branch into the current branch    `git merge <branch-name>`
  Delete a branch that has been merged      `git branch -d <branch-name>`

Example workflow:

``` bash
git switch -c feature-login
# Make changes to your files
git add .
git commit -m "Add login feature"
git switch main
git pull
git merge feature-login
```

This is an example for a simple local workflow. In a team, follow the
project's review and branch-protection rules; a Pull Request is often
used instead of merging directly into `main`.

### H. Connect to GitHub and Synchronize

  ----------------------------------------------------------------------------------
  Task                                Command
  ----------------------------------- ----------------------------------------------
  List configured remotes             `git remote -v`

  Add a remote named `origin`         `git remote add origin <repository-url>`

  Change the URL of `origin`          `git remote set-url origin <repository-url>`

  Download remote updates without     `git fetch`
  merging                             

  Fetch and integrate updates for the `git pull`
  current branch                      

  Push a branch to `origin`           `git push -u origin <branch-name>`

  Push later commits to the           `git push`
  configured upstream                 
  ----------------------------------------------------------------------------------

Example: connect an existing local repository to a GitHub repository and
push the `main` branch:

``` bash
git remote add origin <repository-url>
git branch -M main
git push -u origin main
```

If `origin` is already configured, do not add it again. Check with
`git remote -v` first. Authentication may require signing in through Git
Credential Manager, a browser, or an SSH key.

### I. Rename, Remove, or Ignore Files

  -----------------------------------------------------------------------
  Task                                Command
  ----------------------------------- -----------------------------------
  Rename or move a tracked file       `git mv <old-name> <new-name>`

  Remove a file from the working      `git rm <file>`
  directory and stage the deletion    

  Stop tracking a file but keep it    `git rm --cached <file>`
  locally                             
  -----------------------------------------------------------------------

A `.gitignore` file lists files and folders Git should normally ignore,
such as virtual environments, cache files, and local secrets. Add
appropriate entries to `.gitignore` before staging files. Ignoring a
file does not automatically remove it if it is already tracked.

### J. Stash Temporary Changes and Get Help

  -----------------------------------------------------------------------
  Task                                Command
  ----------------------------------- -----------------------------------
  Temporarily save tracked/untracked  `git stash -u`
  changes in a stash                  

  List stashes                        `git stash list`

  Reapply the latest stash and keep   `git stash apply`
  it in the stash list                

  Reapply and remove the latest stash `git stash pop`
  entry                               

  Show help for a command             `git help <command>`

  Show Git version                    `git --version`
  -----------------------------------------------------------------------

Use `git stash` when you need to temporarily put unfinished work aside.
Check the result after applying or popping a stash.

## 8. A Typical Daily Git Workflow

``` bash
git status
git add .
git status
git commit -m "Describe the changes"
git push
```

This checks the repository, stages changes, lets you inspect the staged
state, creates a commit, and pushes it to the configured remote branch.
The first push of a new branch may need
`git push -u origin <branch-name>`.

## 9. Collaboration Using Branches

Branches let team members work on separate tasks without immediately
changing the main branch.

Example:

-   Developer A works on a login feature in `feature-login`.
-   Developer B works on a dashboard in `feature-dashboard`.
-   Each developer commits and pushes their branch.
-   Team members review proposed changes through Pull Requests.
-   Approved changes are merged into the target branch, often `main`.

### Branch vs. Merge vs. Pull Request

  -----------------------------------------------------------------------
  Concept                             Purpose
  ----------------------------------- -----------------------------------
  Branch                              Provides a separate line of
                                      development

  Merge                               Combines changes from one branch
                                      into another

  Pull Request                        Proposes changes for review and
                                      merging on a hosting platform such
                                      as GitHub

  Code review                         Helps catch errors and improve code
                                      quality before merging
  -----------------------------------------------------------------------

A Pull Request does not itself guarantee that code is merged. A user
with the appropriate permissions must merge it, unless the repository
uses an automated process.

## 10. Example: Contribute a Feature Through GitHub

``` bash
git switch main
git pull
git switch -c feature-data-cleaning
# Edit files
git status
git add .
git commit -m "Add data cleaning"
git push -u origin feature-data-cleaning
```

Then open GitHub in your browser and create a Pull Request from
`feature-data-cleaning` into the project's target branch. Review
feedback, make any required updates, push the additional commits, and
merge when approved.

## 11. Frequently Confused Commands

  -----------------------------------------------------------------------
  Command                             What it does
  ----------------------------------- -----------------------------------
  `git add`                           Stages changes for the next commit

  `git commit`                        Saves staged changes in local
                                      history

  `git push`                          Sends local commits to a remote

  `git fetch`                         Downloads remote updates but does
                                      not integrate them into the current
                                      branch

  `git pull`                          Fetches and integrates remote
                                      updates

  `git restore <file>`                Discards unstaged edits to a file

  `git restore --staged <file>`       Unstages a file without discarding
                                      its edits

  `git revert <commit-id>`            Creates a new commit that reverses
                                      an earlier commit

  `git reset`                         Moves the current branch/HEAD or
                                      resets the staging area, depending
                                      on options; understand the chosen
                                      form before using it
  -----------------------------------------------------------------------

## 12. Quick Revision

-   **Git** tracks code changes and history locally.
-   **GitHub** hosts repositories online and supports collaboration.
-   **Stage** the changes you want to include in a commit.
-   **Commit** saves a snapshot in local history.
-   **Push** uploads commits; **fetch** downloads remote updates;
    **pull** fetches and integrates them.
-   **Branching** supports independent work; **merging** combines
    changes.
-   **Pull Requests** support review before changes are merged.
-   Check `git status` often and review changes before committing.
-   Be careful with commands that discard work, especially
    `git restore <file>` and `git reset --hard`.
