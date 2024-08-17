---
date: 2024-08-17T10:51:00-04:00
title: "Setting Awal Untuk Menjalankan Model Huggingface di Laptop Sendiri"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Huggingface
  - Summarization
  - Text Analysis
  - R Studio
  - Python
  - Deep Learning
---


Sampai saat ini ada lima tulisan saya terkait [*large language model*
dari situs *Huggingface*](https://ikanx101.com/tags/#huggingface).
Beberapa model tersebut saya jalankan via *cloud* dari *Huggingface*
langsung dan lainnya saya **tarik ke local laptop** saya.

Beberapa hari yang lalu, salah seorang rekan saya bertanya kepada saya:

> *Mas, lebih baik kita run model ini di laptop atau di local yah?*

Saya jawab: **tergantung**.

Jika:

- Kita hendak melakukan komputasi yang sifatnya banyak, kontinu, dan
  otomatis (tanpa proses *re-training* apapun), bisa jadi kita harus
  menariknya ke *local computer*.
- Hanya sesekali saja karena iseng atau eksperimental, tidak perlu harus
  menariknya ke *local computer*. Pakai *cloud Huggingface* saja sudah
  cukup.

Dulu saya pernah menuliskan [cara *setting* awal agar laptop saya bisa
menggunakan model dari
Huggingface](https://ikanx101.com/blog/install-huggingface/). Waktu itu
saya menggunakan laptop *Dell* dengan Ubuntu OS versi 20.04 LTS.

Kali ini saya akan berikan satu cara lain *setting* awal Python,
*transformers*, dan *Huggingface*. Sebagai informasi, saat ini laptop
*Dell* saya diisi *ChromeOS Flex* dengan *Linux Debian*.

Pertama-tama kita buka *terminal* dan masuk sebagai *super user* dengan
perintah:

    sudo su

*Oh iya*, kita pastikan dulu *Python3* sudah ter-*install* di dalam OS
kita.

Berikut adalah skrip tahap pertama yang dimasukkan ke dalam *terminal*
beserta penjelasannya:

    # kita update dan upgrade sistem linux nya
    apt update
    apt upgrade -y

    # kita akan install python3 environment terlebih dahulu
    apt install python3.11-venv
    python3 -m venv .env
    source .env/bin/activate

Skrip di atas bermaksud untuk menyiapkan *environment* *Python3* yang
diperlukan. Skrip selanjutnya sebagai berikut:

    # proses install transformers dan torch
    pip install transformers
    pip install 'transformers[torch]'
    pip install diffusers["torch"] transformers

Setelah instalasi *transformers*, *diffusers*, dan *torch* selesai, kita
sudah bisa langsung menarik model dari *Huggingface* dan langsung
mencobanya.

## Contoh: Model LLM

Sebagai contoh, saya akan menarik [model *summarization* berbahasa
Indonesia berikut
ini](https://huggingface.co/cahya/bert2gpt-indonesian-summarization).

    from transformers import BertTokenizer, EncoderDecoderModel

    tokenizer = BertTokenizer.from_pretrained("cahya/bert2gpt-indonesian-summarization")
    tokenizer.bos_token = tokenizer.cls_token
    tokenizer.eos_token = tokenizer.sep_token
    model = EncoderDecoderModel.from_pretrained("cahya/bert2gpt-indonesian-summarization")

    #  
    ARTICLE_TO_SUMMARIZE = "Wahjoe Sardono(Ejaan Yang Disempurnakan: Wahyu Sardono; 30 September 1951 – 30 Desember 2001), lebih dikenal dengan mononim Dono, adalah seorang aktor, pelawak, dan dosen berkebangsaan Indonesia. Ia merupakan salah satu personel dari kelompok lawak Warkop. Lahir di Delanggu, Klaten, karier Dono dirintis saat masih berkuliah di Universitas Indonesia (UI) dengan menjadi karikaturis dan aktivis sosial. Ia kemudian dipilih sebagai asisten dosen oleh guru besar sosiologi UI, yaitu Selo Soemardjan, dan mulai mengajar sejumlah kuliah umum serta kuliah kelompok bersama Paulus Wirutomo. Setelah lulus kuliah, Dono mulai membangun popularitas bersama kelompok Warkop yang kemudian membintangi 34 judul film komedi selama periode tahun 1980 hingga 1995. Mereka melanjutkan kesuksesan tersebut melalui program seri televisi dari tahun 1996 hingga 2001. Selain itu, Dono juga aktif menulis beberapa novel dan artikel mengenai isu sosial di media massa hingga akhir hayatnya. Ia meninggal dunia pada akhir tahun 2001 akibat kanker paru-paru."

    # generate summary
    input_ids = tokenizer.encode(ARTICLE_TO_SUMMARIZE, return_tensors='pt')
    summary_ids = model.generate(input_ids,
                min_length=20,
                max_length=80, 
                num_beams=10,
                repetition_penalty=2.5, 
                length_penalty=1.0, 
                early_stopping=True,
                no_repeat_ngram_size=2,
                use_cache=True,
                do_sample = True,
                temperature = 0.8,
                top_k = 50,
                top_p = 0.95)

    summary_text = tokenizer.decode(summary_ids[0], skip_special_tokens=True)
    print(summary_text)

Berikut adalah hasilnya:

`wahjoe sardono adalah seorang aktor, pelawak, dan dosen berkebangsaan indonesia. ia merupakan salah satu personel dari kelompok lawak warkop yang kemudian membintangi judul film komedi selama periode tahun 1980 - 2001.`

Berikut adalah *screenshot*-nya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/huggingface/setting/hug.png" data-fig-align="center" width="600" />

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
