
git merge --abort
git add .
git add <file-name>
git remote add origin <repository-url>

git status
git branch -a
git checkout <commit-id>  #1a2b3c4
git cherry-pick <commit-id>
git clone <repository-url>
git checkout <branch-name>
git reset <file-name>
git log --oneline --graph

git commit -m "Your commit message"
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git checkout -b <branch-name>
git tag <tag-name>
git branch -d <branch-name>
git diff <commit1> <commit2>
git fetch
git tag <new-tag-name> <old-tag-name>
git push origin <branch-name> --force
gh auth login
git tag
git log
git merge <branch-name>
git checkout -b <new-branch-name>
git pull origin <branch-name>

git push origin <tag-name>
git push --tags
git push origin <branch-name>


git rebase --continue
git rebase origin/<branch-name>
git rebase <branch-name>

git branch -r
git remote -v

git remote remove origin
git branch -m <new-branch-name>
git reset --hard <commit-id>
git branch --track <branch-name> origin/<branch-name>

# Resolve conflicts manually, then use:
git add <resolved-file>
git merge --continue

git revert <commit-id>
git reset --hard HEAD^
git branch --set-upstream-to=origin/<branch-name> <local-branch-name>
git rebase -i <commit-id>


git stash apply
git stash list
git stash

git rm --cached <file-name>
# git rm --cached .env

git show <commit-id>