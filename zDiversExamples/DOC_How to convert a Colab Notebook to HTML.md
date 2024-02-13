## How to Convert a Google Colab (.ipynb) Notebook to HTML
##### 5.06.2023 dbe - initial version
---   
Often, we need to share our code explanations and figures written in a Google **Colab Jupyter Notebook** (.py or .ipynb files) with our friends/colleagues/bosses. 
The simple way is to save them as PDF files. However, PDF files are unable to load large figures or the markdown explanations.

An alternative way is by *sharing them as .html files* as it’s simple in just a click away of opening the notebook, 
without having Python installed or colab environment.

Below are the step-by-step method on how to export your Google colab Jupyter notebook as an HTML file.

--- 
### 1) Download your colab notebook
```
click File --> Download  --> Download .ipynb
```

![image](https://github.com/sawubona-gmbh/BINA-FS23-WORK/assets/52699611/24aeeb52-d6be-4aea-8b10-73f7b83e476e)


---  
### 2) Re-upload the downloaded .ipynb to the session storage  
You will have .ipynb file in your *session storage* (as marked with a blue arrow).

![image](https://github.com/sawubona-gmbh/BINA-FS23-WORK/assets/52699611/1f25aa5d-bc36-45b9-ba3f-d6083d06149e)

---  
### 3) Open Terminal and Run the below Script   
Open terminal (as marked with the bluew arrow)

![image](https://github.com/sawubona-gmbh/BINA-FS23-WORK/assets/52699611/1ada1404-0639-4d5e-899b-6d4ed9a22c3d)

... and run the below Script
```
/content# jupyter nbconvert --to html //Your notebook path file.ipynb
```
![image](https://github.com/sawubona-gmbh/BINA-FS23-WORK/assets/52699611/5f33ffba-25e0-4533-9657-e92fa7940973)

Note: and click the refresh icon under Files!

---  
### 4) Download your .html file and share it  
Click the three dots next to your .html file and download.  
**Your HTML file is ready to be share!**

