from transformers import pipeline

pipe = pipeline(model="facebook/bart-large-mnli")

candidate_labels = ['integritas','inovasi','kolaborasi']

sequence_to_classify = str(input("masukan kalimatnya = "))

output = pipe(sequence_to_classify, candidate_labels)

result = str(output)

f = open("result 3.txt","w+")
f.write(result)
f.close()
