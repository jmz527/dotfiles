# dotfiles
shell, git, etc config files

## Order of Operations
.zshenv → .zprofile → .zshrc → .zlogin → .zlogout

## Thanks to:

https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789

Philip Lamplugh, Instructor General Assembly (2013)
PJ Hughes, Instructor General Assembly (2013)

```
curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
```
