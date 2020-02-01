#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot_N <- renderPlot({
    #スライダーで変化させる与えるパラメーター=====
    j <- input$catch
    # catch<-1000
    temp.water<-input$temp.water
    # temp.water<-15
    temp.fish<-input$temp.fish
    # temp.fish<-3
    temp.target<-input$temp.target
    # temp.target<-2
    price_base<-input$price_base
    # price_base<-100
    price_ice <- input$price_ice
    # price_ice <-900/200
    k<- input$k
    m<- input$m
    
    #モデル内で設定しておく定数　スライダーにはとりあえず入れない======
    ice.kind<-1
    
    #適当な係数=====
    # k<-10  #氷の聞き具合
    # m<-1/10 #温度を外した時の単価の減少
    #モデル内で来まる値　仮に与える場合======
    # price_fish<-100
    
    #======
    
    
    
    
    #初期値======
    #氷の量と、漁獲量による、temp.difの行列 それぞれ10段階
    X<-matrix(0,10,10)
    Price<-matrix(0,10,10)
    P <- matrix(0,10,10) #Profitの行列
    #========
    # j<-5
    
    for(i in 1:nrow(X)){  #ice は i   1~10  1単位は200㎏
      ice<-i*100
      catch<-j*1000
      
      #モデル１　目標温度からの差　catch1単位あたり
      temp.dif<-{ (temp.water+temp.fish-temp.target)*catch  - k* ice*ice.kind 
        # - k* ice*333.36*0.239/1000　    #氷の潜熱(℃/氷1kg)  333.36*0.239/1000
        #魚槽の比熱のつもり
      } /catch
      #氷自体の温度が-18℃くらいということを計算に入れるべき。　氷の潜熱も考慮すべき
      # 潜熱　333.36J/g 1J=  　約 0.2390 cal
      # print(temp.dif)
      X[i,j]<-temp.dif
      
      #モデル２　魚の温度と、単価
      #目標温度から離れると、単価が安くなる  （冷やしすぎも、冷やさなさすぎも×　)
      # 現実は氷不足の方が単価は安くなることをどのように表現するか 
      price_fish<- ifelse(temp.dif>0,
                          price_base * (1 - m* temp.dif^2),
                          price_base * (1 - m* 1/10 * temp.dif^2) )
      Price[i,j]<-price_fish
      #モデル３　利益の構造　最大化を目指す
      profit<- price_fish*catch - price_ice*ice
      P[i,j]<-profit
      
    }
    
    X
    Price
    P
    
    #描画======
    par(mfrow=c(4,1))
    par(oma = c(2, 2, 1, 1))
    par(mar = c(5, 5, 1, 5))
    
    # iceを変化させたときの、利益の変動や、冷やしこみ温度との差を表示
    
    #ice と　temp.difの関係
    matplot(X[,j],
            ylab="Temp Diff",
            ylim=c(-20,20),
            type="b",lty=1,cex.lab=2,cex.axis=2,lwd=2) 
    abline(h=0)
    #差が0のｔ
    #temp.dif と　単価の関係
    matplot(X[,j],Price[,j],
            xlab="Temp Diff",ylab="Price",
            xlim=c(10,-10),
            ylim=c(price_base*4/5,price_base),
            type="b",lty=1,cex.lab=2,cex.axis=2,lwd=2) 
    abline(v=0)
    #差が0のｔ
    #ice と　単価の関係
    matplot(Price[,j],
            ylab="Price",
            ylim=c(price_base*4/5,price_base),
            type="l",lty=1,cex.lab=2,cex.axis=2,lwd=2)
    #ice と　利益の関係
    matplot(P[,j]/10000,
            ylab="Profit(10^4 Yen",
            type="b",lty=1,cex.lab=2,cex.axis=2,lwd=2)
    
    mtext("Ice(100kg)",side = 1,    # 1:下側、2:左側、3:上側、4:右側
          line = 1,               # マージン領域の何行目か
          outer = TRUE,cex = 2
    )
    # matplot(N,ylab="Biomass", ylim=c(0,100),type="l",lty=1,cex.lab=2,cex.axis=2,lwd=2)
    # matplot(catch,ylab="Catch", ylim=c(0,max(catch)),type="l",lty=1,cex.lab=2,cex.axis=2,lwd=2)
    # mtext("Year",side = 1,    # 1:下側、2:左側、3:上側、4:右側
    #       line = 1,               # マージン領域の何行目か    
    #       outer = TRUE,cex = 2
    # )
    #======
    
    
    
    #▲ 今後入れ込みたいもの
    # 等利益線図     X軸ice　y軸catch で　Z軸　PROFIT
    # 冷やしこみ時間（漁獲後の経過時間）、
    #氷の翌日への持越し量　、　前日からの残り分ー溶けた分
    # 最高価格が変わっても最適点が変わらない　→TempDiffと価格の関係に　Price.maxが線形で入っているため
    #　氷の温度も無限に冷やせるわけでないと思うので、-30度とか、下限値が必要　潜熱も。
    # TempDiffと価格の関係が現実的か？　経営体によって判断されているのでは？
    
  })
  
})
