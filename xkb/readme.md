# キー配置入れ替え

symbols/mysymbols
の３つ目に追加すると無変換キーと一緒に押した場合に機能する．
例えば
  key <AD06> { [ y, Y, Home ] };
とすれば
無変換キー＋y でHome キーが押されたことになる．

## 参考にしたページ

基本の書き方
https://did2memo.net/2015/07/20/ubuntu-xkb-muhenkan-hotkey/#i-3
https://jou4.hateblo.jp/entry/2015/04/04/191437

現在の設定を見る
setxkbmap -print
https://keyamb.hatenablog.com/entry/2016/06/04/130022

Mozc でもとに戻らないように
http://cha.la.coocan.jp/doc/UbuntuKeyBind.html