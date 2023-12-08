"


## 1.    Name and briefly describe the type of GLM this is.
This is specfied by the 'family' within the brms call which is binomial. 
This means that we are fitting a logistic regression model. 
As our repsonse variable is binary (mated or not) this model is sutiable 
for our needs. In short you're fitting the data with a sigmoid function based on 
estimated coeficients, log odds, and predictor variables. 

## 2.    What is the model formula MATED | trials(1) ~ BATTLE + (1|HERD) set up to evaluate/estimate?
Mated | trials(1) denotes that you are modeling the probability of success (Mated) given a singular trial

+ (1|HERD) denotes that we are treating the herd as a random interecept.

## 3.    What is the prior argument telling brms to do?

Prior is denoting that we are using a normal distribution prior with a mean of 0 and standard deviation of 4.
This will be used to generally place the posterior (acquired data) in order to acquire the likelihood of the data.

## 4.    What are the iter and chains arguments telling brms to do?
The iter arugment denotes how many iterations the simulation should go through to reach potential convergence.

The chains argument is denoting how many Markov chains to start. I'm assuming these chains are run in parralel and this is 
why brms compiles C code. Continuing off of this, having three chains means we are starting from 3 seperate initial conditions
of parameters.

"

``` {r brms stuff dont run}
library(brms)

pronghorn <- read.delim("pronghorn2023.tsv")
print(head(pronghorn))
brm_fit <- brm(MATED | trials(1) ~ BATTLE + (1|HERD),
               family='binomial', 
               prior = prior(normal(0, 4), class = sd),
               iter = 4000, chains = 3,
               data=pronghorn)

```