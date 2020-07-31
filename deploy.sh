#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github
echo 'javazd.cn' > CNAME
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:zd125735/zd125735.github.io.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://zd125735:${GITHUB_TOKEN}@github.com/zd125735.github.io.git
  git config --global user.name "zhoudong507@126.com"
  git config --global user.email "zhoudong507@126.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master # 推送到github

# deploy to coding
echo 'javazd.cn' > CNAME  # 自定义域名
if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
  codingUrl=git@e.coding.net:wangoon/blog/blog.git
else
  codingUrl=https://SwyytuepLW:${CODING_TOKEN}@e.coding.net:wangoon/blog/blog.git
fi
git add -A
git commit -m "${msg}"
git push -f $codingUrl master # 推送到coding 


cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist