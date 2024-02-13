# LB07 - Process Mining README
###### Last update: 30/3/23 dbe - PM4PY examples added for BINA FS23
</br>

![MSc-WI_BINA_LB7_Process Mining](https://user-images.githubusercontent.com/52699611/160862823-016e7439-4c25-4566-a2fe-a68951726883.PNG)

## A) Process Mining

**Process mining**  bridges the gap between traditional *model-based process analysis* (e.g., simulation and other business process management techniques) and data-centric analysis techniques such as *machine learning and data mining*. Process mining seeks the confrontation between **event data** (i.e., observed behavior) and **process models** (hand-made or discovered automatically). This technology has become available only recently, but it can be applied to any type of operational processes (organizations and systems).  

Example applications include: 
+ analyzing treatment processes in hospitals (e.g. [Process Mining with Python Healthcare Example](https://medium.com/@c3_62722/process-mining-with-python-tutorial-a-healthcare-application-part-1-ae02027a050)), 
+ improving customer service processes in a multinational, 
+ understanding the browsing behavior of customers using booking site, 
+ analyzing failures of a baggage handling system, 
+ and improving the user interface of an X-ray machine. 

All of these applications have in common that *dynamic behavior needs to be related to process models*. 

![image](https://user-images.githubusercontent.com/52699611/160899702-2b43476a-bc20-437b-ba16-a43eb40919e0.png)

> *"Data science is the profession of the future, because organizations that are unable to use (big) data in a smart way will not survive. However, it is not sufficient to focus on data storage and data analysis. The data scientist also needs to relate data to process analysis"*  
> *Wil. van der Aalst, Professor at RWTH Aachen University*
 
* The Process and Data Science ([PADS](https://www.pads.rwth-aachen.de/))Group @RWTH Aachen University and their [Process Mining](http://www.processmining.org/home.html) website   
* The famous [Process Mining: Data science in Action Course](https://de.coursera.org/learn/process-mining) of Wil van der Aalst @Coursera  
* The [Process Analytics](https://pa.win.tue.nl/) research group @TU Eindhoven   
* [Celonis](https://www.faz.net/aktuell/wirtschaft/digitec/process-mining-start-up-celonis-steigt-zum-decacorn-auf-17370152.html) Mitgründer und Co-Vorstandsvorsitzender Bastian Nominacher spricht von einem gewaltigen Potential im Markt für Process Mining.  Im Mai 2021 wurde Celonis zum ersten Start-Up aus Deutschland, dessen Marktwert 10 Milliarden US-Dollar überschreiten konnte. Der geplante Börsengang der Celonis-Aktie für 2020 wurde verworfen, aktuell warten Anleger auf ein neues Datum im 2022

</br>  

**Petri Nets** is a formal and graphical appealing language which is appropriate for *modelling systems with concurrency and resource sharing*. Petri Nets has been under development since the beginning of the 60'ies, where [Carl Adam Petri](https://www.informatik.uni-hamburg.de/TGI/mitarbeiter/profs/petri.html) defined the language. It was the first time a general theory for discrete parallel systems was formulated. The language is a generalisation of automata theory such that the concept of concurrently occurring events can be expressed.

![image](https://user-images.githubusercontent.com/52699611/160917484-8061be15-db07-4a49-be3e-66cf5b466f1e.png)


* [Petri Nets World](https://www2.informatik.uni-hamburg.de/TGI/PetriNets/index.php) is to provide a variety of online services for the international Petri Nets community  
* [PIPE](http://pipe2.sourceforge.net/) - Platform Independet Petri Net Editor
* A Tool for editing, simulating, and analyzing Colored Petri Nets ([CPN](https://cpntools.org/))  
* Modeling Pedestrian Crossing with Petri nets - A Short Video [Tutorial](https://youtu.be/yHfEmYsqgMk) of the [Business Process Management & Analytics Group](Business Process Management & Analytics Group) @Utrecht University
</br> 

## B) Tools and Examples

**Disco** - discover your process by [Fluxicon](https://fluxicon.com/) - ist besonders auf Geschwindigkeit und Performance ausgelegt und kann so auch größere Datenmengen verarbeiten. Disco ist in der Lage aus den Rohdaten direkt eine Prozesskarte zu erstellen. Anschließend kann der Prozess visuell durch Animationen dargestellt werden, um direkte Fehlerquellen und Engpässe auszumachen. Darüber hinaus bietet Disco eine Vielzahl an Möglichkeiten, die ausgewerteten Daten zu präsentieren und ermöglicht direkte Suchen ohne lange Wartezeiten oder Berechnungen. Disco wurde von zwei PhD Absolvent:innen (Anne Rozinat und Christian Günther) der [TU Eindhoven](https://www.tue.nl/en/) aus dem Forschungsteam von [Prof. Wil van der Aalst](https://www.tue.nl/en/research/researchers/wil-van-der-aalst/) entwickelt. Wil van der Aalst gilt als *[Gottvater des Process-Minings](https://www.handelsblatt.com/technik/it-internet/wil-van-der-aalst-deutschlands-wertvollstes-start-up-celonis-verpflichtet-spitzenforscher-/27543480.html)*  

![image](https://user-images.githubusercontent.com/52699611/160866432-bf0f40d6-3872-4812-89a6-a135ea30a250.png)


* Das Tool [DISCOver your process](https://fluxicon.com/disco/) findet ihr zum Download auf der Fluxicon Website    
* Fluxicon stellt zahlreiche [Video Tutorials](https://www.youtube.com/c/FluxiconProcessMiningCo/videos) zur freien Nutzung her. Spannend sind dabei auch die Praxisberichte von Anwender:innen und Unternehmen. 
* Gutes Intro Tutorial zum Tool durch [Dr. Anne Rozinat](https://youtu.be/SLKXsUI74YA) CO-Founderin von Fluxicon  


* **bupaR** ([Business Process Analysis in R](https://bupar.net/)) an open-source, integrated suite of R-packages for the handling and analysis of business process data. bupaR provides support for different stages in process analysis, such as importing and preprocessing event data, calculating descriptive statistics, process vizualisation and conformance checking. Bei [R-Blogger](https://www.r-bloggers.com/2019/03/process-mining-part-1-3-introduction-to-bupar-package/) findet sich ein gut gemachtes mehrteiliges Tutorial dazu.    
* **PM4PY**  [Process Mining for Python](https://youtu.be/lttSd1sBzq0) a state-of-the-art-process mining library in Python, designed to be used in both academia and industry. See the [Frauenhofer PM4PY Website](https://pm4py.fit.fraunhofer.de/)
