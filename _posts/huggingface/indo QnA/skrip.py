from transformers import pipeline

qa_pipeline = pipeline(
    "question-answering",
    model="Rifky/Indobert-QA",
    tokenizer="Rifky/Indobert-QA"
)

qa_pipeline({
    'context': """Pangeran Harya Dipanegara (atau biasa dikenal dengan nama Pangeran Diponegoro, lahir di Ngayogyakarta Hadiningrat, 11 November 1785 – meninggal di Makassar, Hindia Belanda, 8 Januari 1855 pada umur 69 tahun) adalah salah seorang pahlawan nasional Republik Indonesia, yang memimpin Perang Diponegoro atau Perang Jawa selama periode tahun 1825 hingga 1830 melawan pemerintah Hindia Belanda. Sejarah mencatat, Perang Diponegoro atau Perang Jawa dikenal sebagai perang yang menelan korban terbanyak dalam sejarah Indonesia, yakni 8.000 korban serdadu Hindia Belanda, 7.000 pribumi, dan 200 ribu orang Jawa serta kerugian materi 25 juta Gulden.""",
    'question': "kapan pangeran diponegoro lahir?"
})


# ===========================

# ini yang lama


pipe = pipeline(model="facebook/bart-large-mnli")

candidate_labels = ['integritas','inovasi','kolaborasi']

sequence_to_classify = str(input("masukan kalimatnya = "))

output = pipe(sequence_to_classify, candidate_labels)

result = str(output)

f = open("result 3.txt","w+")
f.write(result)
f.close()
