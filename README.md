git-tag-commit
==============

[![wercker status](https://app.wercker.com/status/6a5312c32250fd888ec44c15289c9085/m "wercker status")](https://app.wercker.com/project/bykey/6a5312c32250fd888ec44c15289c9085)

A Wercker step for tagging a commit


Usage:
```yaml
box: wercker/default
deploy:
  after-steps:
    - matchs/git-tag-commit:
        token: 64ydhb2479a7ecd4337875b4d96sdts8s4d5
        repository: your_user/repository
        branch: some_branch_name
        commit: ef306b2479a7ecd4337875b4d954a4c8fc18 
        tag: some_tag_name
```
