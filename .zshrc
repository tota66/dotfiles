export LANG=ja_JP.UTF-8

## 履歴の保存先
HISTFILE=$HOME/.zsh-history
## メモリに展開する履歴の数
HISTSIZE=100000
## 保存する履歴の数
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit

## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードがない場合でも表示
unsetopt promptcr
## vimライクキーバインド設定
bindkey -e

## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 内部コマンドjobsの出力をデフォルトでjobs -lにする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## 補完候補を一覧表示
setopt auto_resume
## cd時に自動でpush
setopt auto_pushd
## 同じディレクトリをpushしない
setopt pushd_ignore_dups
## タブで順に補完候補を切り替える
setopt auto_menu
## zshの開始，終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command をcommandパス名に展開する
setopt equals
## --prefix=/usr などの=以降も補完
setopt magic_equal_subst
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval `dircolors ~/.dircolors`
    elif type gdircolors > /dev/null 2>&1; then
        eval `gdircolors ~/.dircolors`
    fi
fi
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## ディレクトリ名だけでcd
setopt auto_cd
## 括弧の対応など自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の/を自動的に付加し，次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c}をa b cに展開する機能を使えるようにする
setopt brace_ccl
## ファイル名の展開でディレクトリにマッチした場合末尾に/を付加する
setopt mark_dirs
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

## プロンプトの設定
autoload colors
colors
PROMPT="%{${fg[green]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[green]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}"


# User specific aliases and functions

alias ll='ls -l'
alias la='ls -al'
alias vi='vim'
alias s='sudo'

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'

alias aclog='tail -f /var/log/httpd/access_log'
alias aplog='tail -f /var/log/httpd/error_log'
alias phplog='tail -f /var/log/php.log'

echo "load .zshrc!"
