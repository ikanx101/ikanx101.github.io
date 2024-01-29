nomnoml::nomnoml("#direction: down,
                 [<start> start] -> [<input> f(x), a, b, N]
                 [<input> f(x), a, b, N] -> [PENENTUAN BATAS|sb x: dari a - b|sb y: dari 0 - max(f(x)) di selang a - b|on_target = 0|i = 1]
                 [PENENTUAN BATAS] -> [<choice> i <= N]
                 
                 [<choice> i <= N] -> N [return (on_target/N)]
                 [return (on_target/N)] -> [<end> end]
                 
                 [<choice> i <= N] -> Y [GENERATE RANDOM|xi,yi di batas sb x dan sb y]
                 [GENERATE RANDOM] -> [<choice> yi <= f(xi)]
                 [<choice> yi <= f(xi)] -> Y [on_target = on_target + 1]
                 [<choice> yi <= f(xi)] -> N [i = i+1]
                 [on_target = on_target + 1] -> [i = i+1]
                 [i = i+1] -> [<choice> i <= N]
                 ")
