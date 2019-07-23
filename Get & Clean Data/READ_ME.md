---
title: "READ_ME"
author: "non"
date: "7/23/2019"
output: html_document
---

```{r setup, include=FALSE}
this markdown explains how the script works
```

## R Script

process

1. read .txt file into R : X_train, X_test, y_train, y_test,subject_train, subject_test and features

2. rbind x_train with x_test
         y_train with y_test
         subject_train with subject_test

3. extract column with word mean() or std() with grep()

4. convert y (activities number) to descriptive name of that activities

5. combine subject_ID, y(as descriptive name), x together 

6. group by subject_ID and y, then summarise all using mean() function

7. write the dataframe into .txt file
```{r cars}
thank you
```

