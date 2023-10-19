---
date: 2023-10-19T14:23:00-04:00
title: "Mencoba LLM Huggingface: Merangkum Teks Percakapan Menggunakan AI"
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
  - Conversation
---

Setidaknya sudah ada [empat
artikel](https://ikanx101.com/tags/#huggingface) yang sudah saya tulis
terkait *Large Language Model* (LLM) yang saya dapatkan dari situs
`Huggingface`. Salah satu artikel yang menarik dan bermanfaat bagi saya
adalah LLM untuk [merangkum data berupa teks atau
tulisan](https://ikanx101.com/blog/sum-llm/).

Kali ini saya akan melakukan hal serupa, yakni mencoba LLM dari
`Huggingface` terkait *summarization* atau merangkum. Bedanya dengan
artikel sebelumnya adalah:

> Saya akan merangkum teks berupa percakapan.

Tentu ini adalah hal yang menarik karena kalimat yang digunakan dalam
percakapan tentu berbeda dengan kalimat pada tulisan.

Pertanyaannya:

> Apakah LLM bisa merangkum percakapan dengan baik?

Mari kita coba!

## Model yang Digunakan

Saya menggunakan LLM bernama
[bart-conversation-summarizer](https://huggingface.co/Azma-AI/bart-conversation-summarizer)
buatan maestro luar negeri tentunya. LLM ini dilatih menggunakan
*dataset* berbahasa Inggris, jadi untuk percobaanpun saya akan gunakan
percakapan dalam bahasa Inggris.

### Kasus I

Perhatikan percakapan di bawah ini:

    Rita: Hey Tina? Is it you?
    Tina: Oh Rita! How are you? It’s been a long time.
    Rita: I am fine, what about you? Yes, we last met during the board exams.
    Tina: I’m good too.
    Rita: What are you doing now?
    Tina: Well, I have started my undergraduate studies in English Honours at St. Xaviers College in Mumbai.
    Rita: Wow! You finally got to study the subject you loved the most in school.
    Tina: True. What about you Rita? Wasn’t History your favourite subject?
    Rita: You guessed it right. I took up History Honours in Lady Shri Ram College for Women in Delhi.
    Tina: That’s nice. I am so happy for you.
    Rita: I am happy for you too. Let’s meet up again soon.
    Tina: Yes, sure! We have a lot to catch up on.
    Rita: Bye for now. I have to pick up my sister from tuition. Take care.
    Tina: Bye, will see you soon.

Berikut adalah hasil rangkumannya:

    Tina and Rita haven't seen each other for a long time. 
    Tina has started her undergraduate studies in English Honours at St. Xaviers College in Mumbai. 
    Rita took up History Honours in Lady Shri Ram College for Women in Delhi.

Hasilnya impresif! Layaknya manusia, LLM ini bisa mengambil inti dari
percakapan dari kedua orang teman yang sudah lama tidak bertemu.

### Kasus II

Perhatikan percakapan berikut ini:

    Bank Clerk: Good morning, welcome to the Grammar Bank. How can I help you?
    Customer: Good morning. I would like to open a bank account.
    Bank Clerk: Sure thing. What kind of account would you like to open? A savings account or a checking account?
    Customer: What's the difference?
    Bank Clerk: A checking account is designed to use for everyday transactions. Yet; the money in a savings account is meant to stay in the account and earn interest over time.
    Customer: I see, actually I want to apply for a credit card. That's why I need an account.
    Bank Clerk: Okay then, you probably want a checking account.
    Customer: Well, thank you. I'd like that.
    Bank Clerk: Sure, we will have you fill out an application form, please.
    Customer: No problem.
    Bank Clerk: How much of a credit limit were you looking for?
    Customer:I would like a $10,000 spending limit.
    Bank Clerk: Alright, we will see what we can do. We might be able to get you one of our gold cards with a $10,000 spending limit.
    Customer: Wonderful. Will I also collect points when I use the card?
    Bank Clerk: Sure, with our gold card you will get 10 reward points for every dollar spent.
    Customer: Perfect, I have filled out the form. Do you need anything else?
    Bank Clerk: You just need to deposit a minimum of $250 into your new checking account.
    Customer: Very well, here you are.
    Bank Clerk: Thank you, your account is set up now and your credit card will be mailed to your address within 5 to 10 business days.
    Customer: Thank you for your help, have a good day.
    Bank Clerk: Thank you, you too.

Hasilnya:

    Customer opened a checking account at Grammar Bank. 
    He needs to deposit a minimum of $250 into the account. 
    He will get a credit card with a $10,000 limit and 10 reward points for every dollar spent. 
    The card will be sent to his address within 5 to 10 days.

Hasilnya impresif lagi! Perhatikan bahwa di awal percakapan si *bank
clerk* menawarkan dua jenis rekening dan akhirnya *customer* memilih
salah satu diantaranya karena memiliki tujuan tertentu.

### Kasus III

Perhatikan percakapan berikut ini:

    Patient's mother: Good morning, doctor.
    Doctor: Good morning.
    Patient's mother: My daughter hasn't been feeling well and she has a fever, can you please have a look?
    Doctor: Let's see, hi sweetie, what's your name?
    Dana: Dana.
    Doctor: Can you please take off your jacket and lie down on the bed Dana?
    Patient's mother She is a little scared.
    Doctor: Don't worry, it's not going to hurt, I will just listen to you, I promise.
    Dana: Alright.
    Doctor: Let me listen to your back and check your throat.
    Patient's mother: How is she?
    Doctor: Her throat looks red, I think she has an infection. I will prescribe her some antibiotics, she should take them twice a day.
    Patient's mother: How long does she need to take them?
    Doctor: About a week but she can continue for another week if she doesn't feel better. She should probably rest for a few days too and not go to school.
    Patient's mother: She has become very weak recently. She gets cold very easily too.
    Doctor: It's probably the fever, she may have caught the infection from anyone.
    Patient's mother: Can she take a shower?
    Doctor: Absolutely, taking a cool shower actually help reduce the fever in a natural way.
    Patient's mother: Wow, I didn't know that. When should we come back again?
    Doctor: I want to see her next week, but if she gets worse, you can come and see me regardless.
    Patient's mother: Thank you so much, doctor.
    Doctor: You are welcome, it's my pleasure, I hope she gets well soon.
    Patient's mother: Thank you again, good-bye.
    Doctor: Good-bye.

Hasilnya:

    Patient's daughter has a fever and an infection. 
    Doctor will prescribe her antibiotics twice a day for a week. 
    She should rest for a few days and not go to school. 
    Patient's mother wants to come back next week if she doesn't feel better. 
    She can take a cool shower.

Hasilnya impresif lagi! Di dalam percakapan ada tiga orang yang saling
berinteraksi. LLM berhasil membuat sinopsis percakapan dengan baik.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
