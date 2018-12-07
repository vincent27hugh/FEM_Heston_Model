# The Finite Element Method for Option Pricing under Heston’s Model

## Abstration

Option is one of the most important derivatives in financial markets. Since for some complicated types of options there are no available analytical solutions, we are devoted to applying Finite Element Method (FEM) for option pricing problem in this report. First, we try to resolve the problem of plain vanilla option pricing with analysis of accuracy of FEM by comparing with the analytical solution. Further, in order to demonstrate advantages of the FEM, we take a deeper analysis and derive some equations under [Heston’s model](https://en.wikipedia.org/wiki/Heston_model), which pushes forward the PDE formulation of the model into two- dimensional problem. Finally, we provide a set of examples for pricing European type option under Heston’s model, and associated numerical results to demonstrate the accuracy, convergence and efficiency.

## 2D European Call

* Directly run the file `main_Call.m`. One mesh plot and solution of European price will be generated. Adjust the parameter in `main_Call.m`;
* `Solve.m` and `plot_option.m` files are two function;
* Waiting bars will show the phase of accomplishment of program;
* When programs are done, a alerting sound will ring;

![](EC_Hes_500.jpg)
![](EC_Hes_500_ver.jpg)


## 2D European Put

* Directly run the file `main_Put.m`. One mesh plot and solution of European price will be generated.Adjust the parameter in `main_Put.m`;
* Waiting bars will show the phase of accomplishment of program;
* When programs are done, an alerting sound will ring;

![](EP_H_500.jpg)
![](EP_H_500_ver.jpg)

## Mesh and Basis

* Please directly run file `mesh.m` to get the mesh of spatial resolution of (5,6) with label of triangles and nodes;
* Run file `reference_tri_plot.m` to get the plots of three reference triangles with labels;


**Note**: This is the code for the final project of MA6621, CityU.
