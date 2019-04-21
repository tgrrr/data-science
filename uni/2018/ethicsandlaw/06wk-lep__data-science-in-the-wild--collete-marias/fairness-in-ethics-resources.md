# Fairness in Ethics

https://arxiv.org/abs/1808.00023
The Measure and Mismeasure of Fairness: A Critical Review of Fair Machine Learning
Sam Corbett-Davies, Sharad Goel
(Submitted on 31 Jul 2018 (v1), last revised 14 Aug 2018 (this version, v2))
The nascent field of fair machine learning aims to ensure that decisions guided by algorithms are equitable. Over the last several years, three formal definitions of fairness have gained prominence: (1) anti-classification, meaning that protected attributes---like race, gender, and their proxies---are not explicitly used to make decisions; (2) classification parity, meaning that common measures of predictive performance (e.g., false positive and false negative rates) are equal across groups defined by the protected attributes; and (3) calibration, meaning that conditional on risk estimates, outcomes are independent of protected attributes. Here we show that all three of these fairness definitions suffer from significant statistical limitations. Requiring anti-classification or classification parity can, perversely, harm the very groups they were designed to protect; and calibration, though generally desirable, provides little guarantee that decisions are equitable. In contrast to these formal fairness criteria, we argue that it is often preferable to treat similarly risky people similarly, based on the most statistically accurate estimates of risk that one can produce. Such a strategy, while not universally applicable, often aligns well with policy objectives; notably, this strategy will typically violate both anti-classification and classification parity. In practice, it requires significant effort to construct suitable risk estimates. One must carefully define and measure the targets of prediction to avoid retrenching biases in the data. But, importantly, one cannot generally address these difficulties by requiring that algorithms satisfy popular mathematical formalizations of fairness. By highlighting these challenges in the foundation of fair machine learning, we hope to help researchers and practitioners productively advance the area.

source: 


source: http://www.fatml.org/resources/relevant-scholarship

- Barreno, Marco, Blaine Nelson, Anthony D Joseph, and J D Tygar. “The Security of Machine Learning.” Machine Learning 81, no. 2 (May 20, 2010): 121–48. [doi:10.1007/s10994-010-5188-5]
- Berendt, Bettina, and Soren Preibusch. “Better Decision Support Through Exploratory Discrimination-Aware Data Mining: Foundations and Empirical Evidence.” Artificial Intelligence and Law 22, no. 2 (January 10, 2014): 175–209. [doi:10.1007/s10506-013-9152-0]
- Berendt, Bettina, and Soren Preibusch. “Exploring Discrimination: a User-Centric Evaluation of Discrimination-Aware Data Mining.” 2012 IEEE 12th International Conference on Data Mining Workshops (December 10, 2012): 344–351. [doi:10.1109/ICDMW.2012.109]
- Calders, Toon, and Sicco Verwer. “Three Naive Bayes Approaches for Discrimination-Free Classification.” Data Mining and Knowledge Discovery 21, no. 2 (July 27, 2010): 277–292. [doi:10.1007/s10618-010-0190-x]
- Calders, Toon, Faisal Kamiran, and Mykola Pechenizkiy. “Building Classifiers with Independency Constraints.” 2009 IEEE 9th International Conference on Data Mining Workshops (December 6, 2009): 13–18. [doi:10.1109/ICDMW.2009.83]
- Custers, Bart, and Bart Schermer. "Responsibly Innovating Data Mining and Profiling Tools: A New Approach to Discrimination Sensitive and Privacy Sensitive Attributes." Responsible Innovation 1: Innovative Solutions for Global Issues. (2014): 335-350. [doi:10.1007/978-94-017-8956-1_19]
- Custers, Bart, Toon Calders, Bart Schermer, and Tal Z Zarsky. Discrimination and Privacy in the Information Society: Data Mining and Profiling in Large Databases. Berlin, Heidelberg: Springer Berlin Heidelberg, 2013. [doi:10.1007/978-3-642-30487-3]
- Datta, Anupam, Shayak Sen, and Yair Zick. Algorithmic Transparency via Quantitative Input Influence: Theory and Experiments with Learning Systems, Proceedings of 37th IEEE Symposium on Security and Privacy (May 2016). https://www.andrew.cmu.edu/user/danupam/datta-sen-zick-oakland16.pdf
- DeDeo, Simon. "Wrong Side of the Tracks: Big Data and Protected Categories" (May 27, 2015). arXiv:1412.4643v2
- Dwork, Cynthia, Moritz Hardt, Toniann Pitassi, Omer Reingold, and Richard Zemel. “Fairness Through Awareness,” 2012 Proceedings of the 3rd Innovations in Theoretical Computer Science Conference (January 9, 2012): 214–226. [doi:10.1145/2090236.2090255]
- El-Arini, Khalid, Ulrich Paquet, Ralf Herbrich, Jurgen Van Gael, and Blaise Agüera y Arcas. “Transparent User Models for Personalization,” 18th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining. (August 8, 2012): 678-686. [doi:10.1145/2339530.2339639]
- Feldman, Michael, Sorelle Friedler, John Moeller, Carlos Scheidegger, and Suresh Venkatasubramanian. "Certifying and Removing Disparate Impact" (July 16, 2015). arXiv:1412.3756v3
- Freitas, Alex A. “Comprehensible Classification Models - A Position Paper.” ACM SIGKDD Explorations Newsletter 15, no. 1 (March 17, 2014): 1–10. [doi:10.1145/2594473.2594475]
- Hajian, Sara, and Josep Domingo-Ferrer. “A Methodology for Direct and Indirect Discrimination Prevention in Data Mining.” IEEE Transactions on Knowledge and Data Engineering 25, no. 7 (May 21, 2013): 1445–1459. [doi:10.1109/TKDE.2012.72]
- Hajian, Sara, and Josep Domingo-Ferrer. “A Study on the Impact of Data Anonymization on Anti-Discrimination.” 2012 IEEE 12th International Conference on Data Mining Workshops (December 10, 2012): 352–359. [doi:10.1109/ICDMW.2012.19]
- Hajian, Sara, Josep Domingo-Ferrer, Anna Monreale, Dino Pedreschi, and Fosca Giannotti. "Discrimination- and Privacy-Aware Patterns." Data Mining and Knowledge Discovery. Forthcoming. [doi:10.1007/s10618-014-0393-7]
- Hajian, Sara, Anna Monreale, Dino Pedreschi, Josep Domingo-Ferrer, and Fosca Giannotti. “Fair Pattern Discovery.” 2014 Proceedings of the 29th Annual ACM Symposium on Applied Computing (March 24, 2014): 113-120 [doi:10.1145/2554850.2555043]
- Hajian, Sara, Anna Monreale, Dino Pedreschi, Josep Domingo-Ferrer, and Fosca Giannotti. “Injecting Discrimination and Privacy Awareness Into Pattern Discovery.” 2012 IEEE 12th International Conference on Data Mining Workshops (December 10, 2012): 360–369, [doi:10.1109/ICDMW.2012.51]
- Hajian, Sara, Josep Domingo-Ferrer, and Antoni Martinez-Balleste. “Discrimination Prevention in Data Mining for Intrusion and Crime Detection.” 2011 IEEE Symposium on Computational Intelligence in Cyber Security (April 11-15, 2011): 47–54. [doi:10.1109/CICYBS.2011.5949405]
- Hajian, Sara, Josep Domingo-Ferrer, and Oriol Farràs. “Generalization-Based Privacy Preservation and Discrimination Prevention in Data Publishing and Mining.” Data Mining and Knowledge Discovery 28, no. 5-6 (January 25, 2014): 1158-1188. [doi:10.1007/s10618-014-0346-1]
- Hajian, Sara. “Simultaneous Discrimination Prevention and Privacy Protection in Data Publishing and Mining.” PhD Thesis. Universitat Rovira i Virgili. (June 28, 2013). arXiv:1306.6805
- Herlocker, Jonathan L, Joseph A Konstan, and John Riedl. “Explaining Collaborative Filtering Recommendations,” Proceedings of the 2000 ACM Conference on Computer Supported Cooperative Work. (December 1, 2000): 241-250. [doi:10.1145/358916.358995.]
- Kamiran, Faisal, and Toon Calders. “Classifying Without Discriminating.” 2009 2nd International Conference on Computer, Control and Communication. (17-18, February 2009): 1–6. [doi:10.1109/IC4.2009.4909197]
- Kamiran, Faisal, and Toon Calders. “Data Preprocessing Techniques for Classification Without Discrimination.” Knowledge and Information Systems 33, no. 1 (December 3, 2011): 1–33. [doi:10.1007/s10115-011-0463-8]
- Kamiran, Faisal, Asim Karim, Sicco Verwer, and Heike Goudriaan. “Classifying Socially Sensitive Data Without Discrimination: an Analysis of a Crime Suspect Dataset.” 2012 IEEE 12th International Conference on Data Mining Workshops (December 10, 2012): 370–377. [doi:10.1109/ICDMW.2012.117]
- Kamiran, Faisal, Indrė Žliobaitė, and Toon Calders. “Quantifying Explainable Discrimination and Removing Illegal Discrimination in Automated Decision Making.” Knowledge and Information Systems 35, no. 3 (November 18, 2012): 613–44. [doi:10.1007/s10115-012-0584-8]
- Kamiran, Faisal, Toon Calders, and Mykola Pechenizkiy. “Discrimination Aware Decision Tree Learning.” 2010 IEEE 10th International Conference on Data Mining (December 13-17, 2010): 869–874. [doi:10.1109/ICDM.2010.50]
- Kamishima, Toshihiro, Shotaro Akaho, and Jun Sakuma. “Fairness-Aware Learning Through Regularization Approach.” 2011 IEEE 11th International Conference on Data Mining Workshops (December 11, 2011): 643–650. [doi:10.1109/ICDMW.2011.83]
- Kamishima, Toshihiro, Shotaro Akaho, Hideki Asoh, and Jun Sakuma. “Considerations on Fairness-Aware Data Mining." 2012 IEEE 12th International Conference on Data Mining Workshops. (December 10, 2012): 378–385. [doi:10.1109/ICDMW.2012.101]
- Kamishima, Toshihiro, Shotaro Akaho, Hideki Asoh, and Jun Sakuma. “Fairness-Aware Classifier with Prejudice Remover Regularizer.” 2012 European Conference on Machine Learning and Principles and Practice of Knowledge Discovery in Databases. (September 24-28, 2012): 35–50. [doi:10.1007/978-3-642-33486-3_3]
- Kamishima, Toshihiro, Shotaro Akaho, Hideki Asoh, and Jun Sakuma. “The Independence of Fairness-Aware Classifiers." 2013 IEEE 13th International Conference on Data Mining Workshops. (December 7-10, 2013): 849–58. [doi:10.1109/ICDMW.2013.133]
- Letham, Benjamin, Cynthia Rudin, Tyler McCormick and David Madigan. "Building Interpretable Classifiers with Rules using Bayesian Analysis: Building a Better Stroke Prediction Model." (August 2013). http://web.mit.edu/rudin/www/LethamRuMcMa14.pdf
- Lowd, Daniel, and Christopher Meek. “Adversarial Learning,” 11th ACM SIGKDD International Conference on Knowledge Discovery in Data Mining. (August 21, 2005): 641-647. [doi:10.1145/1081870.1081950]
- Luong, Binh Thanh, Salvatore Ruggieri, and Franco Turini. “K-NN as an Implementation of Situation Testing for Discrimination Discovery and Prevention.” 17th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining. (July 21, 2011): 502–510. [doi:10.1145/2020408.2020488]
- Mancuhan, Koray, and Chris Clifton. “Combating Discrimination Using Bayesian Networks.” Artificial Intelligence and Law 22, no. 2 (February 17, 2014): 211–238. [doi:10.1007/s10506-014-9156-4]
- Mancuhan, Koray, and Chris Clifton. “Discriminatory Decision Policy Aware Classification." 2012 IEEE 12th International Conference on Data Mining Workshops. (December 10, 2012): 386–393. [doi:10.1109/ICDMW.2012.96]
- Martens, David, and Bart Baesens, “Building Acceptable Classification Models.” Annals of Information Systems 8 (2010): 53-74. [doi:10.1007/978-1-4419-1280-0_3]
- Martens, David, and Foster Provost, “Explaining Data-Driven Document Classifications,” MIS Quarterly 38, no. 1 (March 2014): 73–99. http://misq.org/explaining-data-driven-document-classifications.html
- Martens, David, Jan Vanthienen, Wouter Verbeke, and Bart Baesens. "Performance of Classification Models from a User Perspective." Decision Support Systems 51, no. 4 (November 2011): 782–793. [doi:10.1016/j.dss.2011.01.01]
- Mascetti, Sergio, Annarita Ricci, and Salvatore Ruggieri. “Introduction to Special Issue on Computational Methods for Enforcing Privacy and Fairness in the Knowledge Society.” Artificial Intelligence and Law 22, no. 2 (February 11, 2014): 109–11. [doi:10.1007/s10506-014-9153-7]
- Moritz Hardt, A Study of Privacy and Fairness in Sensitive Data Analysis, PhD Thesis, Princeton University (2011) http://arks.princeton.edu/ark:/88435/dsp01vq27zn422
- Pedreschi, Dino, Salvatore Ruggieri, and Franco Turini. “A Study of Top-K Measures for Discrimination Discovery.” 2012 Proceedings of the 27th Annual ACM Symposium on Applied Computing. (March 26, 2012) 126–131. [doi:10.1145/2245276.2245303]
- Pedreschi, Dino, Salvatore Ruggieri, and Franco Turini. “Measuring Discrimination in Socially-Sensitive Decision Records.” Proceedings of the 2009 SIAM International Conference on Data Mining. (2009): 581-592. [doi:10.1137/1.9781611972795.50]
- Pedreschi, Dino, Salvatore Ruggieri, and Franco Turini. “Discrimination-Aware Data Mining.” 14th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining. (July 24, 2008): 560-568. [doi:10.1145/1401890.1401959]
- Pope, Devin G, and Justin R Sydnor. “Implementing Anti-Discrimination Policies in Statistical Profiling Models.” American Economic Journal: Economic Policy 3, no. 3 (August 2011): 206–31. [doi:10.1257/pol.3.3.206]
- Romei, Andrea, and Salvatore Ruggieri. “A Multidisciplinary Survey on Discrimination Analysis.” The Knowledge Engineering Review 29, no. 5 (April 3, 2013): 1–57. [doi:10.1017/S0269888913000039]
- Romei, Andrea, Salvatore Ruggieri, and Franco Turini. “Discovering Gender Discrimination in Project Funding." 2012 IEEE 12th International Conference on Data Mining Workshops. (December 10, 2012): 394–401. [doi:10.1109/ICDMW.2012.39]
- Romei, Andrea, Salvatore Ruggieri, and Franco Turini. “Discrimination Discovery in Scientific Project Evaluation: A Case Study.” Expert Systems with Applications 40, no. 15 (November 2013): 6064–79. [doi:10.1016/j.eswa.2013.05.016]
- Ruggieri, Salvatore, Dino Pedreschi, and Franco Turini. “Data Mining for Discrimination Discovery.” ACM Transactions on Knowledge Discovery From Data 4, no. 2 (May 1, 2010): 1–40. [doi:10.1145/1754428.1754432]
- Ruggieri, Salvatore, Dino Pedreschi, and Franco Turini. “DCUBE: Discrimination Discovery in Databases." Proceedings of the 2010 ACM SIGMOD International Conference on Management of Data (June 6, 2010): 1127–1130. [doi:10.1145/1807167.1807298]
- Ruggieri, Salvatore, Dino Pedreschi, and Franco Turini. “Integrating Induction and Deduction for Finding Evidence of Discrimination.” Artificial Intelligence and Law 18, no. 1 (June 5, 2010): 1–43. [doi:10.1007/s10506-010-9089-5]
- Ruggieri, Salvatore, Hajian, Sara, Faisal Kamiran, and Xiangliang Zhang. “Anti-discrimination Analysis Using Privacy Attack Strategies.” 2014 European Conference on Machine Learning and Principles and Practice of Knowledge Discovery in Databases (2014): 694-710. [doi:10.1007/978-3-662-44851-9_44]
- Ruggieri, Salvatore. “Data Anonymity Meets Non-Discrimination.” 2013 IEEE 13th International Conference on Data Mining Workshops (December 7-10, 2013): 875–882. [doi:10.1109/ICDMW.2013.56]
- Sinha, Rashmi, and Kirsten Swearingen. “The Role of Transparency in Recommender Systems.” CHI '02 Extended Abstracts on Human Factors in Computing Systems. (April 20, 2002): 830-831. [doi:10.1145/506443.506619.]
- Ustun, Berk, and Cynthia Rudin. "Methods and Models for Interpretable Linear Classification" (October 1, 2014). arXiv:1405.4047
- Zemel, Rich, Yu Wu, Kevin Swersky, Toni Pitassi, and Cynthia Dwork. “Learning Fair Representations.” 30th International Conference on Machine Learning (June 16-21, 2013) http://jmlr.org/proceedings/papers/v28/zemel13.html
- Žliobaitė, Indre, Faisal Kamiran, and Toon Calders. “Handling Conditional Discrimination." 2011 IEEE 11th International Conference on Data Mining. (December 11-14, 2011): 992–1001. [doi:10.1109/ICDM.2011.72]

[doi:10.1007/s10994-010-5188-5]: http://doi:10.1007/s10994-010-5188-5
[doi:10.1007/s10506-013-9152-0]: http://doi:10.1007/s10506-013-9152-0
[doi:10.1109/ICDMW.2012.109]: http://doi:10.1109/ICDMW.2012.109
[doi:10.1007/s10618-010-0190-x]: http://doi:10.1007/s10618-010-0190-x
[doi:10.1109/ICDMW.2009.83]: http://doi:10.1109/ICDMW.2009.83
[doi:10.1007/978-94-017-8956-1_19]: http://doi:10.1007/978-94-017-8956-1_19
[doi:10.1007/978-3-642-30487-3]: http://doi:10.1007/978-3-642-30487-3
[doi:10.1145/2090236.2090255]: http://doi:10.1145/2090236.2090255
[doi:10.1145/2339530.2339639]: http://doi:10.1145/2339530.2339639
[doi:10.1145/2594473.2594475]: http://doi:10.1145/2594473.2594475
[doi:10.1109/TKDE.2012.72]: http://doi:10.1109/TKDE.2012.72
[doi:10.1109/ICDMW.2012.19]: http://doi:10.1109/ICDMW.2012.19
[doi:10.1007/s10618-014-0393-7]: http://doi:10.1007/s10618-014-0393-7
[doi:10.1145/2554850.2555043]: http://doi:10.1145/2554850.2555043
[doi:10.1109/ICDMW.2012.51]: http://doi:10.1109/ICDMW.2012.51
[doi:10.1109/CICYBS.2011.5949405]: http://doi:10.1109/CICYBS.2011.5949405
[doi:10.1007/s10618-014-0346-1]: http://doi:10.1007/s10618-014-0346-1
[doi:10.1145/358916.358995.]: http://doi:10.1145/358916.358995.
[doi:10.1109/IC4.2009.4909197]: http://doi:10.1109/IC4.2009.4909197
[doi:10.1007/s10115-011-0463-8]: http://doi:10.1007/s10115-011-0463-8
[doi:10.1109/ICDMW.2012.117]: http://doi:10.1109/ICDMW.2012.117
[doi:10.1007/s10115-012-0584-8]: http://doi:10.1007/s10115-012-0584-8
[doi:10.1109/ICDM.2010.50]: http://doi:10.1109/ICDM.2010.50
[doi:10.1109/ICDMW.2011.83]: http://doi:10.1109/ICDMW.2011.83
[doi:10.1109/ICDMW.2012.101]: http://doi:10.1109/ICDMW.2012.101
[doi:10.1007/978-3-642-33486-3_3]: http://doi:10.1007/978-3-642-33486-3_3
[doi:10.1109/ICDMW.2013.133]: http://doi:10.1109/ICDMW.2013.133
[doi:10.1145/1081870.1081950]: http://doi:10.1145/1081870.1081950
[doi:10.1145/2020408.2020488]: http://doi:10.1145/2020408.2020488
[doi:10.1007/s10506-014-9156-4]: http://doi:10.1007/s10506-014-9156-4
[doi:10.1109/ICDMW.2012.96]: http://doi:10.1109/ICDMW.2012.96
[doi:10.1007/978-1-4419-1280-0_3]: http://doi:10.1007/978-1-4419-1280-0_3
[doi:10.1016/j.dss.2011.01.01]: http://doi:10.1016/j.dss.2011.01.01
[doi:10.1007/s10506-014-9153-7]: http://doi:10.1007/s10506-014-9153-7
[doi:10.1145/2245276.2245303]: http://doi:10.1145/2245276.2245303
[doi:10.1137/1.9781611972795.50]: http://doi:10.1137/1.9781611972795.50
[doi:10.1145/1401890.1401959]: http://doi:10.1145/1401890.1401959
[doi:10.1257/pol.3.3.206]: http://doi:10.1257/pol.3.3.206
[doi:10.1017/S0269888913000039]: http://doi:10.1017/S0269888913000039
[doi:10.1109/ICDMW.2012.39]: http://doi:10.1109/ICDMW.2012.39
[doi:10.1016/j.eswa.2013.05.016]: http://doi:10.1016/j.eswa.2013.05.016
[doi:10.1145/1754428.1754432]: http://doi:10.1145/1754428.1754432
[doi:10.1145/1807167.1807298]: http://doi:10.1145/1807167.1807298
[doi:10.1007/s10506-010-9089-5]: http://doi:10.1007/s10506-010-9089-5
[doi:10.1007/978-3-662-44851-9_44]: http://doi:10.1007/978-3-662-44851-9_44
[doi:10.1109/ICDMW.2013.56]: http://doi:10.1109/ICDMW.2013.56
[doi:10.1145/506443.506619.]: http://doi:10.1145/506443.506619.
[doi:10.1109/ICDM.2011.72]: http://doi:10.1109/ICDM.2011.72