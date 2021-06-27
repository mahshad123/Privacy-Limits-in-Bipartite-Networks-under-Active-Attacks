# Privacy-Limits-in-Bipartite-Networks-under-Active-Attacks
This work considers active deanonymization of bipartite networks. The scenario arises naturally in evaluating privacy in various applications such as social networks, mobility networks, and medical databases. For instance, in active deanonymization of social networks, an anonymous victim is targeted by an attacker (e.g. the victim visits the attacker's website), and the attacker queries her group memberships (e.g. by querying the browser history) to deanonymize her. In this work, the fundamental limits of privacy, in terms of the minimum number of queries necessary for deanonymization, is investigated. The bipartite network is generated based on linear and sublinear preferential attachment, and the stochastic block model. The victim's identity is chosen randomly based on a distribution modeling the users' risk of being the victim (e.g. probability of visiting the website). An attack algorithm is proposed which builds upon techniques from communication with feedback, and its performance, in terms of expected number of queries, is analyzed. Simulation results are provided to verify the theoretical derivations. In this project, we provide several simulations of synthesized and real-world attacks to verify the theoretical results presented in the paper and gain further intuition regarding the users’ privacy risks under such attack scenarios.  For detailed problem formulation you can visit the following paper: https://arxiv.org/abs/2106.04766

In this article there are three different scenario: 

**Random Data**
1. Effect of Alpha on the number of queries: for this Scenario please run alpha_main.m
2. Effect of multiple query noises on the number of queries:  for this Scenario please run query_noise_main.m
3. Effect of multiple Scan noises on the number of queries:   for this Scenario please run scan_noise_main.m

In this article we investigate the scenarios on real network data either: 

**Real Data**
for the dataset for this part please look at "dataset.txt"
