nomnoml::nomnoml("
                 [Langkah Kerja] -> [Analitik]
                 [Analitik] -> [Eksak|Mengintegralkan langsung]
                 [Langkah Kerja] -> [Numerik]
                 [Numerik] -> [Brute force]
                 [Numerik] -> [Modifikasi Monte Carlo]
                 ")
nomnoml::nomnoml("#direction: down,
                 [<start> start] -> [<input> f(x), a, b, N]
                 [<input> f(x), a, b, N] -> [PENENTUAN BATAS|sb x: dari a - b|sb y: dari 0 - max(f(x)) di selang a - b|on_target = 0|i = 0]
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

nomnoml::nomnoml("#direction: down,
                 [<start> start] -> [<input> f(x), a, b, N]
                 [<input> f(x), a, b, N] -> [DEFINE|sum = 0|i = 0]
                 [DEFINE] -> [<choice> i <= N]
                 
                 [<choice> i <= N] -> N [return (sum * (b-a) / N)]
                 [return (sum * (b-a) / N)] -> [<end> end]
                 
                 [<choice> i <= N] -> Y [GENERATE RANDOM|xi di selang a - b]
                 [GENERATE RANDOM] -> [sum = sum + (b-a)*f(xi)]
                 [sum = sum + (b-a)*f(xi)] -> [i = i + 1]
                 [i = i + 1] -> [<choice> i <= N]
                 ")
