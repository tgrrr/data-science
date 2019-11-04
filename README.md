# Data Science tldr

- **Alpha:** Very much a work in Progress

We work off a public and private repository, this is how I sync them:

## Git Operations:

To push to the private Github remote `next`:

```zsh
git checkout next
git fetch next
git pull next/

git checkout -b <feature/featureName>
# do some work

git add -A
git commit -m 'feature/featureName details...'
git push next

git checkout next
git fetch next

git rebase -i feature/featureName

OR

git merge feature/featureName
```

### To make it public:
To push to the private Github remote `public`:

```zsh
git checkout public
git fetch public

git cherry-pick -n <COMMIT HASH> # Grabs just the branch of changes to make public

git add -A
git commit -m 'feature/featureName details...'
git push public
```

### Setup on a new machine:

- Setup remote upstreams:
```zsh
git remote add next git@github.com:tgrrr/data-science-next.git
git remote add origin	git@github.com:tgrrr/data-science-next.git
git remote add public	git@github.com:tgrrr/data-science.git
```

Then, `git remote -v` gives us:

```zsh
next	git@github.com:tgrrr/data-science-next.git (fetch)
next	git@github.com:tgrrr/data-science-next.git (push)
origin	git@github.com:tgrrr/data-science-next.git (fetch)
origin	git@github.com:tgrrr/data-science-next.git (push)
public	git@github.com:tgrrr/data-science.git (fetch)
public	git@github.com:tgrrr/data-science.git (push)
```




Note: git push origin is set to the same repo as next
