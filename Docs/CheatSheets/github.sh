gh auth login  # Log in to GitHub via the command line.
git add .  # Stage all changes for the next commit.
git add <file-name>  # Stage a specific file for the next commit.
git branch -a  # List all branches, both local and remote.
git branch -d <branch-name>  # Delete a local branch.
git branch -m <new-branch-name>  # Rename the current branch.
git branch -r  # List remote branches.
git branch --set-upstream-to=origin/<branch-name> <local-branch-name>  # Set the upstream branch for the local branch.
git branch --track <branch-name> origin/<branch-name>  # Track a remote branch with a local branch.
git checkout <branch-name>  # Switch to an existing branch.
git checkout <commit-id>  # Checkout a specific commit (detached HEAD).
git checkout -b <branch-name>  # Create and switch to a new branch.
git checkout -b <new-branch-name>  # Create a new branch and switch to it.
git cherry-pick <commit-id>  # Apply changes from a specific commit to the current branch.
git clone <repository-url>  # Clone a repository into a new directory.
git commit -m "Your commit message"  # Commit staged changes with a message.
git config --global user.email "you@example.com"  # Set the global email for Git.
git config --global user.name "Your Name"  # Set the global username for Git.
git diff <commit1> <commit2>  # Show differences between two commits.
git fetch  # Download updates from the remote repository without merging.
git log  # Show the commit history.
git log --oneline --graph  # Display the commit history in a graphical format.
git merge <branch-name>  # Merge a branch into the current branch.
git merge --abort  # Abort a merge in progress due to conflicts.
git merge --continue  # Continue a merge after resolving conflicts.
git pull origin <branch-name>  # Fetch and merge updates from a remote branch.
git push origin <branch-name>  # Push local changes to a remote branch.
git push origin <branch-name> --force  # Force-push changes to a remote branch.
git push origin <tag-name>  # Push a specific tag to a remote repository.
git push --tags  # Push all tags to the remote repository.
git rebase <branch-name>  # Reapply commits from another branch onto the current branch.
git rebase --continue  # Continue a rebase after resolving conflicts.
git rebase origin/<branch-name>  # Reapply commits from the remote branch.
git rebase -i <commit-id>  # Interactively rebase commits.
git remote add origin <repository-url>  # Add a remote repository URL.
git remote remove origin  # Remove the origin remote repository.
git remote -v  # Show remote repository URLs.
git reset --hard <commit-id>  # Reset the working directory to a specific commit, discarding all changes.
git reset --hard HEAD^  # Reset to the previous commit, discarding changes.
git reset <file-name>  # Unstage a specific file.
git revert <commit-id>  # Revert a specific commit by creating a new commit that undoes it.
git rm --cached <file-name>  # Remove a file from the staging area but keep it in the working directory.
git show <commit-id>  # Show details of a specific commit.
git stash  # Save uncommitted changes temporarily.
git stash apply  # Reapply stashed changes to the working directory.
git stash list  # List all stashed changes.
git status  # Show the status of the working directory and staging area.
git tag  # List all tags.
git tag <tag-name>  # Create a new tag.
git tag <new-tag-name> <old-tag-name>  # Rename an existing tag to a new one.