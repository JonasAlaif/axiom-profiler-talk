# Examples from Axiom Profiler 1.0

This folder contains various versions of the running example used in the "The Axiom Profiler: Understanding and Debugging SMT Quantifier Instantiations" paper as well as corresponding log files that can be loaded directly into the Axiom Profiler. The example has been slightly modified for the talk on Axiom Profiler 2.0. Tested with z3 versions 4.8.7 and 4.12.2.

`a_running-example.smt2` contains the running example as shown in Fig. 1

`b_running-example.smt2` contains the fixes described in Sec. 5 (Simple Matching 
Loops), i.e. choosing a different trigger for the nxt axiom

`c_running-example.smt2` fixes the issue with the injectivity axiom as described in Sec. 5 (High Branching)

`d_running-example.smt2` fixes the issue with the sortedness axiom
