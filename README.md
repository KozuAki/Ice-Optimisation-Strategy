# Ice-Optimisation-Strategy
氷の最適化を検討するシミュレーション　の　試作品

定置網漁業において最適化できるコストで、もっとも手近な氷の使用量について考えてみる。

・氷を使う　　　→　氷代が増える

・氷を使わない　→　魚の冷却が甘くなり、市場評価が下がって売り上げが減る

の関係を仮定し、ちょうどいい氷の量を、魚の単価、魚の量や、海水温などによって探るシミュレーション

http://kozuaki.shinyapps.io/test4


＊グラフの説明
基本的に、X軸は　Ice(100kg) 、ただし2つ目のグラフだけX軸がTempDiff


1つ目：　氷使用量と、漁獲物の目標温度からのずれ（TempDiff）の関係　（かなり適当で、要検証）

2つ目：　漁獲物の目標温度からのずれ（TempDiff）と単価の関係　

3つ目：　氷使用量と単価の関係　右上の図の横軸を氷使用量に戻したもの

4つ目：　氷使用量と利益の関係
　　　　　利益は、「漁獲量×単価　―　氷資料量×氷単価」　と単純なもの
     
★　4つ目のグラフの最高点となるXの値（氷使用量）が、利益最大点　となる解



＊＊＊中のからくり

氷を最適化できず、冷却失敗（目標体温からのズレTempDiffが0より離れる）すると、単価が下がるところが肝（2つ目の図）

　氷が足らず、目標温度まで冷えない、つまりTempDiff>0(ここでは左側）となると、大きく単価が下がる
 
  氷が多すぎて過冷却、つまりTempDiff<0(ここでは右側）となっても、若干単価が下がる

「m_冷却失敗ペナルティー」を大きくすると、冷却失敗で単価が大きく下がる





＊＊＊当たり前だけど、シミュで確認できること

冷却失敗ペナルティーが0（冷却と価格は無関係）だと、氷が0（不使用）が利益最大

氷単価が０だと、TempDiffが0となる点が利益最大点だが、氷単価が高いと利益最大となる氷使用量は前述の点よりも少ない氷の量となる


＊＊＊足りない要素

k_氷の効き具合　や　m_冷却失敗ペナルティーの係数の妥当性の検証（船槽の比熱など）

時間変化（冷却時間の長さ）

氷（既存の砕氷）の翌日への持越しと、前日からの繰り越し

急速に効くが持ちの悪い氷（スラリーアイス）と、効きは遅いが翌日まで持ち越せる氷（既存の砕氷）のトレードオフ

高級魚と、低価格魚で、単価カーブが同じという違和感のある仮定



****参考研究
神奈川県水産試験場が90年代後半に行った　氷の最適化の研究の報告書

定置網船において、水温15度～25℃　漁獲量1000㎏～3000㎏　氷量330㎏～670㎏　での実験結果が公表されている


