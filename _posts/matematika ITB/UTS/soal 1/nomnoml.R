nomnoml::nomnoml("#direction: down,
                 [<start> start] -> [Input n]
                 [Input n] -> [<choice> Integer?\nAND\nn>0]
                 [<choice> Integer?\nAND\nn>0] -> NO[<usecase> STOP]
                 [<choice> Integer?\nAND\nn>0] -> YES[<choice> n<=1]
                 [<choice> n<=1] -> YES[Return 1]
                 [<choice> n<=1] -> NO[a = 1\ni = 2]
                 [a = 1\ni = 2] -> [<choice> i <= n]
                 
                 [<choice> i <= n] -> YES [a = a * i]
                 [a = a * i] -> [i = i + 1]
                 [<choice> i <= n] <- [i = i + 1]
                 
                 [<choice> i <= n] -> NO [Return a]
                 
                 [Return a] -> [<end> stop]",
                 png = "flow.png", 600, 900)
