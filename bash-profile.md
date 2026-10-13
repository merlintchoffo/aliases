# Raccourcis `.bash_profile`

Alias définis dans le `~/.bash_profile`.

```bash
# NPM
alias nt="npm test"

# SHELL / BASH
alias cafe='caffeinate'
alias source="source ~/.bash_profile"
alias term="open -a iTerm"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias pp="pwd"
alias openbash="vim ~/.bash_profile"

# npm
alias ys="yarn start"
alias nts="npm run ts"
alias nt="npm run test"
alias nte="npm run test:e2e"
alias nteh="npm run test:e2e:headed"
alias ns="npm run start"
alias nd="npm run dev"
alias np="npm run prod"
alias nprimsa="npm run prisma"

# pnpm (mêmes raccourcis que npm, préfixe pn)
alias pnts="pnpm run ts"
alias pnt="pnpm run test"
alias pnte="pnpm run test:e2e"
alias pnteh="pnpm run test:e2e:headed"
alias pns="pnpm run start"
alias pnd="pnpm run dev"
alias pnb="pnpm run build"
alias pnp="pnpm run prod"
alias pnprimsa="pnpm run prisma"

# DÉPLOIEMENT
alias hero="heroku"
alias vv="vercel"

# GIT
alias gcl="git config --list"
alias gr="git remote"
alias grl="git reflog"
alias gf="git fetch"
alias gri="git rebase -i"
alias grsho="git reset --soft HEAD^1"
alias grh="git reset --hard"
alias gcount="git rev-list --count"
alias gdb="git log --oneline --graph --decorate --abbrev-commit"
alias gs="git status"
alias ga="git add"
alias gm="git commit"
alias gma="git commit --amend --no-edit"
alias gpf="git push -f"
alias gpush="git push"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log"
alias glo="git log --oneline"
alias gpf="git push -f"
alias gp="git push"
alias gpull="git pull"
alias gst="git stash"
alias gstl="git stash list"
alias gsta="git stash apply"
alias gstal="git stash apply stash@{0}"
alias gsts="git stash save"
alias gd="git diff"
```
